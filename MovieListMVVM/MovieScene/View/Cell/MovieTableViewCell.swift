//
//  MovieTableViewCell.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overView: UILabel!

    @IBOutlet weak var posterImageView: UIImageView!

    var cellViewModel: MovieCellViewModel? {
        didSet {
            self.title.text = cellViewModel?.title
            self.overView.text = cellViewModel?.dess

            self.posterImageView?.image = cellViewModel?.image.image
            cellViewModel?.image.startDownload()
            cellViewModel?.image.completeDownload = { [weak self] image in
                guard let self = self else { return }
                self.posterImageView.image = image
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellViewModel?.image.completeDownload = nil
        self.posterImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
