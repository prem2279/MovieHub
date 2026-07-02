//
//  RedViewController.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/29/26.
//

import UIKit

class RedViewController: UIViewController, CommonPageConfigurable {
    weak var coordinator: NavigationCordinatorProtocol?
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        view.backgroundColor = .red
        view.addSubview(backButton)
        view.addSubview(nextButton)
        view.addSubview(label)
        pinTopCorner(child: label, parent: view, top: 200)
        centerX(child: label, parent: view)
        pinTopToBottomCorner(child: nextButton, parent: label, top: 50)
        centerX(child: nextButton, parent: view)
        pinTopToBottomCorner(child: backButton, parent: nextButton, top: 50)
        centerX(child: backButton, parent: nextButton)
        setWidthHeightConstraints(element: nextButton, width: 100, height: 50)
        setWidthHeightConstraints(element: backButton, width: 100, height: 50)
        
        backButton.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
    }
    
}


extension RedViewController {
    @objc
    func backPage() {
      //TODO: - Call Cordinator to go back
        coordinator?.back()
    }
    
    @objc
    func nextPage() {
        coordinator?.navigateToBluePage(content:"This is Blue Color Page")
    }
}

extension RedViewController {
    func configure(with content: String) {
        label.text = content
    }
}
