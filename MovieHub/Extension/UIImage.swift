//
//  UIImage.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

import UIKit

extension UIImage {
    
    func downloadImage(
        for url: String,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ){
        
        guard let serverURL = URL(string: APIEndPoints.image.basePath + url) else{
            print("Invalid URL")
            completion(.failure(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: serverURL)
        
        URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            
            if error != nil {
                print("Error occured \(error!.localizedDescription)")
                completion(.failure(.serverError))
                return
            }
            
            guard let data else {
                print("No data from the server")
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
