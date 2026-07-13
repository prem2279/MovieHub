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
    weak var coordinator: NavigationCordinatorProtocol?
    
    private let searchController = UISearchController(searchResultsController: nil)

    // Debounces API calls while the user is still typing
    private var searchDebounceWorkItem: DispatchWorkItem?
    
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
        setupUI()
        setupSearchBar()
        loadData()
    }
}

//MARK: - Fetching the Data

extension MoviesDashboardViewController {
    func loadData() {
        
        viewModel.getData(){
            [weak self] error in
            DispatchQueue.main.async {
                switch error {
                case "":
                    // Success State
                    self?.movieTableView.reloadData()
                    self?.loader.stopAnimating()
                case nil:
                    // Loading State
                    self?.loader.startAnimating()
                default:
                    //Failure State
                    self?.showError(message: error ?? "")
                    self?.loader.stopAnimating()
                    
                }
                
            }
        }
    }
}

//MARK: - UI SetUp Methods

extension MoviesDashboardViewController{
    private func setupUI() {
        view.addSubview(movieTableView)
        view.addSubview(loader)
        title = "Movie Hub"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "sparkles"),
            style: .plain,
            target: self,
            action: #selector(openAISearch)
        )
        
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        centerX(child: loader, parent: view)
        centerY(child: loader, parent: view)
    }
    
    private func setupSearchBar() {

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.showsCancelButton = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        //definesPresentationContext = true
    }

    @objc private func openAISearch() {
        coordinator?.presentMovieChat()
    }
}

//MARK: - Search Results Updator

extension MoviesDashboardViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        let searchText = searchController.searchBar.text ?? ""

        searchDebounceWorkItem?.cancel()

        let workItem = DispatchWorkItem { [weak self] in
            self?.searchMovies(searchText: searchText)
        }

        searchDebounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: workItem)
    }

    private func searchMovies(searchText: String) {

        viewModel.searchMovies(searchText: searchText){
            [weak self] error in
            DispatchQueue.main.async {
                switch error {
                case "":
                    // Success State
                    self?.movieTableView.reloadData()
                    self?.loader.stopAnimating()
                case nil:
                    // Loading State
                    self?.loader.startAnimating()
                default:
                    //Failure State
                    self?.showError(message: error ?? "")
                    self?.loader.stopAnimating()
                }
            }
        }
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
        //print(coordinator, "called")
        coordinator?.navigateToMovieDetails(movie: viewModel.getMovieByIndex(at: indexPath.row))
    }
}

