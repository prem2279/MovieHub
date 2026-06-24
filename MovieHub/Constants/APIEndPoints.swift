//
//  APIEndPoints.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

enum APIEndPoints {
    case movies
    case image

    var basePath: String {
        switch self {
        case .movies:
            return "https://api.themoviedb.org/3/discover/movie?api_key="
        case .image:
            return "https://image.tmdb.org/t/p/w500"
        }
    
    }
}
