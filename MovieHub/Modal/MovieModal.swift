//
//  MovieModal.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

import UIKit

struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String
    let title: String
    let id : Int
    let genreIds: [Int]
    let voteAverage: Double
    let overview: String
    let originalLanguage : String
    let originalTitle: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let softcore: Bool
    let video: Bool
    let voteCount: Int

    
    enum CodingKeys: String, CodingKey{
        case adult
        case backdropPath = "backdrop_path"
        case id
        case title
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case overview
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case softcore
        case video
        case voteCount = "vote_count"
    }
}

struct Movies: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey{
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
