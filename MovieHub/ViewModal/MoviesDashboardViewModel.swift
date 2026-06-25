//
//  Untitled.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/24/26.
//
// MARK: - Movies Delegate Protocol
protocol MoviesDashboardDelegate: AnyObject{
    func getMoviesCount() -> Int
    func getMovieByIndex(at index: Int) -> Movie?
    func getData(completion: @escaping ((Result<Void, NetworkError>)) -> ())
}

class MoviesDashboardViewModel {
    
    // MARK: - Properties
    
    var movies:[Movie]?
    
    // MARK: - Methods
    func getData(completion: @escaping ((Result<Void, NetworkError>)) -> ()) {
        let completion: (Result<Movies, NetworkError>) -> Void = {
            [weak self] result in
            switch result{
            case .success(let data):
                self?.movies = data.results
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        APIClient.shared.request(endpoint: .movies, completion: completion)
    }
}

// MARK: - TableView Helpers

extension MoviesDashboardViewModel: MoviesDashboardDelegate {
    func getMoviesCount() -> Int {
        guard let movies else { return 0 }
        return movies.count
    }
    
    func getMovieByIndex(at index: Int) -> Movie? {
        guard let movies else { return nil }
        
        if movies.indices.contains(index){
            return movies[index]
        }
        
        return nil
    }
    
    
}


