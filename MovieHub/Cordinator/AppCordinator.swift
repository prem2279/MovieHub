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
        
        navigationCoordinator = NavigationCordinator(navigationController: navigationController)
        let loginVC = LoginViewController()
        loginVC.coordinator = navigationCoordinator
        navigationController.viewControllers.append(loginVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
