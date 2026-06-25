//
//  UIViewController.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/24/26.
//
import UIKit

extension UIViewController{
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
