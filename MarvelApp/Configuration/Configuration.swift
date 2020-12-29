//
//  Configuration.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import Foundation

struct MarvelRequest {
    
    // MARK: - Properties
    
    private static let publicApiKey = "47e5f0f98702a73f53026a3d430f02de"
    private static let privateApiKey = "b6845771983e591de3de7282a1d2547d04bfb335"
    private static let baseUrl = URL(string: "https://gateway.marvel.com/v1/public/")!
    
    // Mark: -
    
    private struct Endpoints {
        static let charactersList = "characters"
    }
    
    // MARK: - Public API
    
    struct Urls {
        
        // MARK: - Characters List URL
        
        static var charactersList: URL {
            // Create URL components
            guard var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
                fatalError("Unable to create URL components for Marvel Request")
            }
            
            let dateFormatter = DateFormatter()
            let timestamp = dateFormatter.string(from: Date())
            
            // Define query items
            components.queryItems = [
                URLQueryItem(name: "apikey", value: publicApiKey),
                URLQueryItem(name: "ts", value: timestamp),
                URLQueryItem(name: "hash", value: CryptoManager.MD5(string: timestamp + privateApiKey + publicApiKey))
            ]
            
            // Get full URL
            guard let url = components.url?.appendingPathComponent(Endpoints.charactersList) else {
                fatalError("Unable to create URL for Marvel Request")
            }
            
            return url
        }
    }
}
