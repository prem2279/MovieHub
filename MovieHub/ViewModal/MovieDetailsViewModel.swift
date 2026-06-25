//
//  Untitled.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/25/26.
//
import UIKit

final class MovieDetailsViewModel {

    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String? {
        movie.title
    }
    
    var genre: String {
        movie.genreIds.compactMap {
            MovieGenre(rawValue: $0)?.name
        }.joined(separator: " • ")
    }
    
    var rating: String {
        String(movie.voteAverage)
    }
    
    var releaseYear: String {
        movie.releaseYear
    }
    
    var overview: String {
        movie.overview
    }
    
    var popularity: String {
        String(movie.popularity)
    }
    
    var language: String {
        movie.originalLanguage
    }
    
    var originalTitle: String {
        movie.originalTitle
    }
    
    var votes: String {
        String(movie.voteCount)
    }
    
    var adultContent: String {
        movie.adult ? "Yes" : "No"
    }
    
    var releaseDate: String {
        movie.releaseDate
    }
    
    func fetchBackgroundImage(completion: @escaping (Result<UIImage, NetworkError>) -> Void){
        UIImage().downloadImage(for: movie.backdropPath, completion: completion)
    }
    
    func fetchPosterImage(completion: @escaping (Result<UIImage, NetworkError>) -> Void){
        UIImage().downloadImage(for: movie.posterPath, completion: completion)
    }
}
