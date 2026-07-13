//
//  APIEndPoints.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

import Foundation

enum APIEndPoints {
    case movies
    case discoverMovies(queryItems: [URLQueryItem])
    case searchMovies(query: String)
    case image

    var basePath: String {
        switch self {
        case .movies, .discoverMovies:
            return "https://api.themoviedb.org/3/discover/movie"
        case .searchMovies:
            return "https://api.themoviedb.org/3/search/movie"
        case .image:
            return "https://image.tmdb.org/t/p/w500"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .movies, .image:
            return []
        case .discoverMovies(let queryItems):
            return queryItems
        case .searchMovies(let query):
            return [URLQueryItem(name: "query", value: query)]
        }
    }
}
