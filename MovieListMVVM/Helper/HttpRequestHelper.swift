//
//  HttpRequestHelper.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import Foundation


enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

class HttpRequestHelper {
    func GET(url: String, complete: @escaping (Bool, Data?) -> Void) {
        let loadUrl = URL(string: url)

        let urlRequest = URLRequest(url: loadUrl! )

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            guard let data = data, error == nil else {
                print("Loading url from api error")
                return
            }
            complete(true,data)
        }.resume()

    }
}
