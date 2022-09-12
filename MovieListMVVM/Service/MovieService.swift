//
//  MovieService.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import Foundation

class MovieService {
    static let defautlUrl = "https://api.themoviedb.org/3/search/movie?api_key=a42e5ead0dd5ae986e1f31cf352051d4&query=marvel"
    func getMovieList(_ url: String, completion: @escaping (Bool, Movies?, String?) -> ()) {
        HttpRequestHelper().GET(url: url) { success, data in
            if success {
                do {
                    let decodedModel = try JSONDecoder().decode(MovieResults.self, from: data!)

                    completion(true, decodedModel.results, nil)
                } catch {
                    completion(false, nil, "parsing error")
                }
            } else {
                completion(false, nil, "http error")
            }
        }
    }
}
