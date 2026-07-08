//
//  UIImage.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

import UIKit

extension UIImageView {
    
    func downloadImage(
        for url: String, defaultImage: String
    ){
        
        guard let serverURL = URL(string: APIEndPoints.image.basePath + url) else{
            print("Invalid URL")
            DispatchQueue.main.async {
                [weak self] in
                self?.image = UIImage(systemName: defaultImage)
            }
            return
        }
        
        if let cachedImage = ImageCache.shared.getImage(for: serverURL) {
            print("Image Coming From Cache")
            DispatchQueue.main.async {
                [weak self] in
                self?.image = cachedImage
            }
            return
        }
        
        let urlRequest = URLRequest(url: serverURL)
        
        URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            
            if error != nil {
                print("Error occured \(error!.localizedDescription)")
                DispatchQueue.main.async {
                    [weak self] in
                    self?.image = UIImage(systemName: defaultImage)
                }
                return
            }
            
            guard let data else {
                print("No data from the server")
                DispatchQueue.main.async {
                    [weak self] in
                    self?.image = UIImage(systemName: defaultImage)
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error Occoured while decoding the Image Data")
                DispatchQueue.main.async {
                    [weak self] in
                    self?.image = UIImage(systemName: defaultImage)
                }
                return
            }
            
            DispatchQueue.main.async {
                [weak self] in
                self?.image = image
            }
            ImageCache.shared.setImage(image, for: serverURL)
            
        }.resume()
    }
}
