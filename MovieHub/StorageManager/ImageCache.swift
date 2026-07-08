//
//  ImageCache.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 7/8/26.
//
import UIKit

final class ImageCache: @unchecked Sendable {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
}
