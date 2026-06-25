//
//  NetworkManager.swift
//  Programatic UI
//
//  Created by Prem Kumar Gundu on 6/9/26.
//

import UIKit

protocol NetworkProtocol: AnyObject{
    func request<T: Decodable>(
        endpoint:APIEndPoints,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
    
}

final class NetworkManager: NetworkProtocol, Sendable{
    
    private let apiKey = "c91ed3a7a344459eccad9687acf0d07e"
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func request<T: Decodable>(
        endpoint:APIEndPoints,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ){
        
        guard let serverURL = URL(string: endpoint.basePath + apiKey) else{
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
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch{
                print("Error occurred: \(error)")
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
}




