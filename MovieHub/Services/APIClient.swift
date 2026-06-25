//
//  APIClient.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 6/25/26.
//


final class APIClient: Sendable, NetworkProtocol{
    static let shared = APIClient()
    private let isInternetAvilable = true
    private init() {}
    
    func request<T: Decodable>( endpoint: APIEndPoints, completion: @escaping (Result<T, NetworkError>) -> Void) {

        if isInternetAvilable {
            NetworkManager.shared.request(
                endpoint: endpoint,
                completion: completion
            )
        } else {
            MockNetworkManager.shared.request(
                endpoint: endpoint,
                completion: completion
            )
        }
    }
    
}
