//
//  ViewController.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/23/26.
//

import UIKit

class MoviesDashboardViewController: UIViewController {

    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private let loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let isInternetAvailable = true
    var movies:[Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: TableViewCells.movieCell)
        movieTableView.delegate = self
        movieTableView.dataSource = self
        //movies = getMovies()
        setUpUI()
        getData(for: APIEndPoints.movies)
        
    }
}

extension MoviesDashboardViewController{
    func setUpUI(){
        view.addSubview(movieTableView)
        view.addSubview(loader)
        title = "Movie Hub"
        
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        centerX(child: loader, parent: view)
        centerY(child: loader, parent: view)
    }
    
    func getData(for endpoint: APIEndPoints) {
        loader.startAnimating()
        let completion: (Result<Movies, NetworkError>) -> Void = { [weak self] result in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
                
                switch result{
                case .success(let data):
                        self?.movies = data.results
                        self?.movieTableView.reloadData()
                    
                case .failure(let error):
                    //DispatchQueue.main.async {
                        self?.showError(message: error.rawValue)
                    //}
                }
            }
        }
        
        if isInternetAvailable{
            NetworkManager.instance.request(endpoint: endpoint, completion: completion)
        }else{
            MockNetworkManager.instance.request(endpoint: endpoint, completion: completion)
        }
    }
}

extension MoviesDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies else {return 0}
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.movieCell, for: indexPath) as? MovieTableViewCell
        
        if let movie = movies?[indexPath.row]{
            cell?.configure(with: movie)
        }
        //DispatchQueue.main.async {
//            cell?.onError = { [weak self] message in
//                self?.showError(message: message)
//            }
        //}
        
        
        return cell ?? UITableViewCell()
    }
}

extension MoviesDashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = MovieDetailsController()
        destination.title = movies?[indexPath.row].originalTitle ?? "Movie Details"
        destination.view.backgroundColor = .black
        destination.loadData(movie: movies?[indexPath.row])
        navigationController?.pushViewController(destination, animated: true)
    }
        
}

extension MoviesDashboardViewController{
    func showError(message: String){
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        let action = UIAlertAction(
            title: "OK",
            style: .default
        )
        
        alert.addAction(action)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
        
    }
}

