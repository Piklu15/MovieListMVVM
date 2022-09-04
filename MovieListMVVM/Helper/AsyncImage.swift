//
//  AsyncImage.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import Foundation
import UIKit

class AsyncImage {
    let url: URL
    private let imageDownloadHelper: ImageDownloadHelperProtocol

    private var imageStore: UIImage?
    private var placeholder: UIImage
    private var isDownloading: Bool = false

    var completeDownload: ((UIImage?) -> Void)?

    var image: UIImage {
        return self.imageStore ?? placeholder
    }


    init(url: String,
         placeholderImage: UIImage = #imageLiteral(resourceName: "imagePlaceholder") ,
         imageDownloadHelper: ImageDownloadHelperProtocol = ImageDownloadHelper()) {
        self.url = URL(string: url)!
        self.placeholder = placeholderImage
        self.imageDownloadHelper = imageDownloadHelper
    }

    func startDownload() {
        if imageStore != nil {
            completeDownload?(image)
        } else {
            if isDownloading { return }
            isDownloading = true
            imageDownloadHelper.download(url: url, completion: { [weak self] (image, response, error) in
                self?.imageStore = image
                self?.isDownloading = false
                DispatchQueue.main.async {
                    self?.completeDownload?(image)
                }
            })
        }
    }
}
