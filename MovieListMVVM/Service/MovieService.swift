//
//  MovieService.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import Foundation

protocol MovieServiceProtocol {
    func getMovieList(completion: @escaping (_ success: Bool, _ results: Movies?, _ error: String?) -> ())
}

class MovieService: MovieServiceProtocol {
    func getMovieList(completion: @escaping (Bool, Movies?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://raw.githubusercontent.com/johncodeos-blog/MVVMiOSExample/main/demo.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Movies.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
