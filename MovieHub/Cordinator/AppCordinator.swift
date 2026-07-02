//
//  AppCordinator.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/29/26.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow?
    private let navigationController = UINavigationController()
    private var navigationCoordinator: NavigationCordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let rootController = MoviesDashboardViewController()
        rootController.viewModel = MoviesDashboardViewModel()
        
        navigationCoordinator = NavigationCordinator(navigationController: navigationController)
        
        rootController.coordinator = navigationCoordinator
        
        navigationController.viewControllers = [rootController]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
