//
//  ViewController.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/23/26.
//

import UIKit

class MoviesDashboardViewController: UIViewController {

    //MARK: - Properties
    
    var viewModel: MoviesDashboardDelegate!
    
    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private let loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: TableViewCells.movieCell)
        movieTableView.delegate = self
        movieTableView.dataSource = self
        //movies = getMovies()
        setUpUI()
        loadData()
        
    }
}

extension MoviesDashboardViewController {
    func loadData() {
        loader.startAnimating()
        viewModel.getData(){
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.movieTableView.reloadData()
                case .failure(let error):
                    self?.showError(message: error.rawValue)
                }
                
                self?.loader.stopAnimating()
            }
            
        }
    }
}

//MARK: - UI SetUp Methods

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
}

//MARK: - Data Source Methods

extension MoviesDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.movieCell, for: indexPath) as? MovieTableViewCell
        if let movie = viewModel.getMovieByIndex(at: indexPath.row) {
            let detailsViewModel = MovieDetailsViewModel(movie: movie)
            cell?.configure(with: detailsViewModel)
        }
        
        return cell ?? UITableViewCell()
    }
}

//MARK: - Delegate Methods

extension MoviesDashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = MovieDetailsViewController()
        if let movie = viewModel.getMovieByIndex(at: indexPath.row) {
            let detailsViewModel = MovieDetailsViewModel(movie: movie)
            destination.configure(with: detailsViewModel)
        }
        navigationController?.pushViewController(destination, animated: true)
    }
}

