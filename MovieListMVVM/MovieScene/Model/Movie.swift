//
//  Movie.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import Foundation

typealias Movies = [Movie]

struct MovieResults: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let overview: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case overview
        case title = "original_title"
        case imageUrl = "poster_path"
    }
}
