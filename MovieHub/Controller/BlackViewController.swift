//
//  BlackViewController.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/29/26.
//

import UIKit

class BlackViewController: UIViewController, CommonPageConfigurable {
    weak var coordinator: NavigationCordinatorProtocol?
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .black
        view.addSubview(homeButton)
        view.addSubview(label)
        view.addSubview(backButton)
        pinTopCorner(child: label, parent: view, top: 200)
        centerX(child: label, parent: view)
        
        pinTopToBottomCorner(child: homeButton, parent: label, top: 50)
        centerX(child: homeButton, parent: view)
        
        pinTopToBottomCorner(child: backButton, parent: homeButton, top: 50)
        centerX(child: backButton, parent: view)
        
        setWidthHeightConstraints(element: homeButton, width: 100, height: 50)
        setWidthHeightConstraints(element: backButton, width: 100, height: 50)
        
        backButton.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(homePage), for: .touchUpInside)
        
    }
    
}


extension BlackViewController {
    @objc
    func backPage() {
      //TODO: - Call Cordinator to go back
        coordinator?.back()
    }
    
    @objc
    func homePage() {
      //TODO: - Call Cordinator to go back
        coordinator?.home()
    }
}

extension BlackViewController {
    func configure(with content: String) {
        label.text = content
    }
}
