//
//  MovieDiscoveryFilters.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 7/13/26.
//

import Foundation
import FoundationModels

// MARK: - Generable Genre

@Generable
enum GenreFilter: String {
    case action, adventure, animation, comedy, crime, documentary, drama, family
    case fantasy, history, horror, music, mystery, romance, scienceFiction
    case tvMovie, thriller, war, western

    // Maps the generated genre to the TMDB genre id from MovieGenre
    var genre: MovieGenre {
        switch self {
        case .action: return .action
        case .adventure: return .adventure
        case .animation: return .animation
        case .comedy: return .comedy
        case .crime: return .crime
        case .documentary: return .documentary
        case .drama: return .drama
        case .family: return .family
        case .fantasy: return .fantasy
        case .history: return .history
        case .horror: return .horror
        case .music: return .music
        case .mystery: return .mystery
        case .romance: return .romance
        case .scienceFiction: return .scienceFiction
        case .tvMovie: return .tvMovie
        case .thriller: return .thriller
        case .war: return .war
        case .western: return .western
        }
    }
}

// MARK: - Generable Sort Order

@Generable
enum SortFilter: String {
    case mostPopular, highestRated, newestFirst, oldestFirst

    var tmdbValue: String {
        switch self {
        case .mostPopular: return "popularity.desc"
        case .highestRated: return "vote_average.desc"
        case .newestFirst: return "primary_release_date.desc"
        case .oldestFirst: return "primary_release_date.asc"
        }
    }
}

// MARK: - Generable Discovery Filters

@Generable
struct MovieDiscoveryFilters {

    @Guide(description: "The specific movie title when the user searches for a movie by name, like 'Inception'. Omit when the user describes movies generally instead of naming one.")
    let movieTitle: String?

    @Guide(description: "Genres mentioned or clearly implied by the request. Empty when no genre is mentioned.")
    let genres: [GenreFilter]

    @Guide(description: "Earliest release year, like 1990 for 'movies from the 90s'. Omit when no time period is mentioned.")
    let releaseYearFrom: Int?

    @Guide(description: "Latest release year, like 1999 for 'movies from the 90s'. Omit when no time period is mentioned.")
    let releaseYearTo: Int?

    @Guide(description: "Minimum average rating from 0 to 10, like 7.5 when the user asks for highly rated movies. Omit when rating isn't mentioned.")
    let minimumRating: Double?

    @Guide(description: "How the user wants the results ordered. Omit when no order is implied.")
    let sortOrder: SortFilter?

    // Builds the TMDB discover query string from the extracted filters
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []

        if !genres.isEmpty {
            let genreIds = genres.map { String($0.genre.rawValue) }.joined(separator: ",")
            items.append(URLQueryItem(name: "with_genres", value: genreIds))
        }

        if let releaseYearFrom {
            items.append(URLQueryItem(name: "primary_release_date.gte", value: "\(releaseYearFrom)-01-01"))
        }

        if let releaseYearTo {
            items.append(URLQueryItem(name: "primary_release_date.lte", value: "\(releaseYearTo)-12-31"))
        }

        if let minimumRating {
            items.append(URLQueryItem(name: "vote_average.gte", value: String(minimumRating)))
        }

        if let sortOrder {
            items.append(URLQueryItem(name: "sort_by", value: sortOrder.tmdbValue))

            // Avoids obscure movies with very few votes dominating rating based sorts
            if sortOrder == .highestRated {
                items.append(URLQueryItem(name: "vote_count.gte", value: "200"))
            }
        }

        return items
    }

    // Human readable description of the filters for the chat reply
    var summary: String {

        if let movieTitle, !movieTitle.isEmpty {
            return "the movie \"\(movieTitle)\""
        }

        var parts: [String] = []

        if genres.isEmpty {
            parts.append("movies")
        } else {
            parts.append(genres.map { $0.genre.name }.joined(separator: ", ") + " movies")
        }

        if let releaseYearFrom, let releaseYearTo {
            parts.append("from \(releaseYearFrom) to \(releaseYearTo)")
        } else if let releaseYearFrom {
            parts.append("from \(releaseYearFrom) onwards")
        } else if let releaseYearTo {
            parts.append("released before \(releaseYearTo)")
        }

        if let minimumRating {
            parts.append("rated \(String(format: "%.1f", minimumRating))+")
        }

        return parts.joined(separator: " ")
    }
}
