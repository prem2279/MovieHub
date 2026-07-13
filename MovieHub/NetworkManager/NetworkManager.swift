//
//  NetworkManager.swift
//  Programatic UI
//
//  Created by Prem Kumar Gundu on 6/9/26.
//

import UIKit
import Alamofire

protocol NetworkProtocol: AnyObject{
    func request<T: Decodable>(
        endpoint:APIEndPoints,
        completion: @escaping (NetworkState<T>) -> Void
    )
    
}

final class NetworkManager: NetworkProtocol, Sendable{
    
    private let apiKey = "c91ed3a7a344459eccad9687acf0d07e"
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func request<T: Decodable>(
        endpoint:APIEndPoints,
        completion: @escaping (NetworkState<T>) -> Void
    ){
        
        completion(.loading)

        guard var components = URLComponents(string: endpoint.basePath) else {
            completion(.failure(error: .invalidURL))
            return
        }

        components.queryItems = endpoint.queryItems + [URLQueryItem(name: "api_key", value: apiKey)]

        guard let serverURL = components.url else {
            completion(.failure(error: .invalidURL))
            return
        }

        AF.request(serverURL)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let movies):
                    completion(.successful(data: movies))
                case .failure(_):
                    completion(.failure(error: .decodingError))
                }
            }
        
//        guard let serverURL = URL(string: endpoint.basePath + apiKey) else{
//            print("Invalid URL")
//            completion(.failure(error: .invalidURL))
//            return
//        }
//        
//        let urlRequest = URLRequest(url: serverURL)
//        
//        URLSession.shared.dataTask(with: urlRequest) {
//            data, response, error in
//            
//            if error != nil {
//                print("Error occured \(error!.localizedDescription)")
//                completion(.failure(error: .serverError))
//                return
//            }
//            
//            guard let data else {
//                print("No data from the server")
//                completion(.failure(error: .noData))
//                return
//            }
//            
//            do {
//                let decodedData = try JSONDecoder().decode(T.self, from: data)
//                completion(.successful(data: decodedData))
//            }catch{
//                print("Error occurred: \(error)")
//                completion(.failure(error: .decodingError))
//            }
//            
//        }.resume()
    }
    
}




