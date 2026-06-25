//
//  MockNetworkManager.swift
//  Programatic UI
//
//  Created by Prem Kumar Gundu on 6/9/26.
//

final class MockNetworkManager: Sendable, NetworkProtocol{
    
    static let shared = MockNetworkManager()
    
    private init(){}
    
    func request<T>(endpoint: APIEndPoints, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        let data: Any?
        
        switch endpoint {
        case .movies:
            if let tempData = getMoviesData(){
                data = tempData
            }else{
                data = nil
            }
        case .image:
            data = nil
        }
        
        if let result = data as? T {
            completion(.success(result))
        } else {
            completion(.failure(.noData))
        }
    }
    
}
