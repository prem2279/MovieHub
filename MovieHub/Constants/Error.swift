//
//  Error.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

import Foundation

enum NetworkError: String, Error  {
    case invalidURL = "Invalid URL"
    case noData = "No Data Received From Server"
    case decodingError = "Decoding Error"
    case serverError = "Server Error"
}

enum NetworkState<T> {
    case loading
    case successful(data: T)
    case failure(error: NetworkError)
}
