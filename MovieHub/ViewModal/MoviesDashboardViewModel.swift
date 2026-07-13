//
//  Untitled.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/24/26.
//
// MARK: - Movies Delegate Protocol
import Foundation
protocol MoviesDashboardDelegate: AnyObject{
    func getMoviesCount() -> Int
    func getMovieByIndex(at index: Int) -> Movie?
    func getData(completionHandler: @escaping (String?) -> ())
    func searchMovies(searchText: String, completionHandler: @escaping (String?) -> ())
}

class MoviesDashboardViewModel {
    
    // MARK: - Properties
    
    private var movies:[Movie] = []
    private var filteredMovies: [Movie] = []
    private var networkInstance: NetworkProtocol
    
    init(networkInstance: NetworkProtocol = NetworkManager.shared) {
        self.networkInstance = networkInstance
    }
    
    // MARK: - Methods
    func getData(completionHandler: @escaping (String?) -> ()) {
//        let completion: (NetworkState<Movies>) -> Void = {
//            [weak self] result in
//            switch result{
//            case .successful(let data):
//                self?.movies = data.results
//                self?.filteredMovies = data.results
//                completionHandler("")
//            case .failure(let error):
//                completionHandler(error.rawValue)
//            case .loading:
//                completionHandler(nil)
//            }
//        }
        
        networkInstance.request(endpoint: .movies){
            [weak self] (result: NetworkState<Movies>) in
            switch result{
            case .successful(let data):
                self?.movies = data.results
                self?.filteredMovies = data.results
                completionHandler("")
            case .failure(let error):
                completionHandler(error.rawValue)
            case .loading:
                completionHandler(nil)
            }
        }
    }

}



extension MoviesDashboardViewModel {
    func searchMovies(searchText: String, completionHandler: @escaping (String?) -> ()) {

        // Empty search restores the default discover list without a network call
        guard !searchText.isEmpty else {
            filteredMovies = movies
            completionHandler("")
            return
        }

        networkInstance.request(endpoint: .searchMovies(query: searchText)){
            [weak self] (result: NetworkState<Movies>) in
            switch result{
            case .successful(let data):
                self?.filteredMovies = data.results
                completionHandler("")
            case .failure(let error):
                completionHandler(error.rawValue)
            case .loading:
                completionHandler(nil)
            }
        }
    }
}

// MARK: - TableView Helpers

extension MoviesDashboardViewModel: MoviesDashboardDelegate {
    func getMoviesCount() -> Int {
        return filteredMovies.count
    }
    
    func getMovieByIndex(at index: Int) -> Movie? {
        
        if filteredMovies.indices.contains(index){
            return filteredMovies[index]
        }
        
        return nil
    }
    
    
}


