//
//  NavigationCordinator.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/29/26.
//
import UIKit

protocol CommonPageConfigurable: UIViewController {
    var coordinator: NavigationCordinatorProtocol? { get set }
    func configure(with content: String)
}

protocol NavigationCordinatorProtocol: AnyObject {
    func back()
    func home()
    func navigateToMovieDetails(movie: Movie?)
    func navigateToRedPage(content: String)
    func navigateToBluePage(content: String)
    func navigateToBlackPage(content: String)
}

class NavigationCordinator: NavigationCordinatorProtocol {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
       
        self.navigationController = navigationController
        
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 25, weight: .bold)
        ]
    }
    
    private func navigateToCommonPage<T: CommonPageConfigurable>(destinationVC: T, content: String) {
        destinationVC.coordinator = self
        destinationVC.configure(with: content)
        navigationController.pushViewController(destinationVC, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func home() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func navigateToMovieDetails(movie: Movie?) {
        let destinationVC = MovieDetailsViewController()
        destinationVC.coordinator = self
        if let movie {
            let vm = MovieDetailsViewModel(movie: movie)
            destinationVC.configure(with: vm)
        }
        navigationController.pushViewController(destinationVC, animated: true)
    }
    
    func navigateToRedPage(content: String) {
        let destinationVC = RedViewController()
        navigateToCommonPage(destinationVC: destinationVC, content: content)
    }
    
    func navigateToBluePage(content: String) {
        let destinationVC = BlueViewController()
        navigateToCommonPage(destinationVC: destinationVC, content: content)
    }
    
    func navigateToBlackPage(content: String) {
        let destinationVC = BlackViewController()
        navigateToCommonPage(destinationVC: destinationVC, content: content)
    }
    
}
