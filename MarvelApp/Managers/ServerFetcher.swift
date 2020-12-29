//
//  ServerFetcher.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import Foundation

class ServerFetcher: DataManager {
    
    // MARK: - API Requests
    
    func getCharactersList(offset: Int, sortDesc: Bool, completion: @escaping CharactersListResult) {
        // Create URL
        let url = MarvelRequest.Urls.charactersList
    
        // Get URL components
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to get URL components for Marvel Request")
        }
    
        // Add offset to path as a query item
        components.queryItems?.append(URLQueryItem(name: "offset", value: String(offset)))
        
        // Add sort
        let orderBy: String = {
            return sortDesc ? CharactersList.NameOrder.desc.rawValue : CharactersList.NameOrder.asc.rawValue
        }()
        components.queryItems?.append(URLQueryItem(name: "orderBy", value: orderBy))
        
        // Get full URL
        guard let fullUrl = components.url else {
            fatalError("Unable to create URL components for Marvel Request")
        }
        
        // Create and execute data task
        URLSession.shared.dataTask(with: fullUrl) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                self?.didFetchCharactersList(data: data, response: response, error: error, completion: completion)
            }
        }.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping ImageResult) {
        // Create and execute data task
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async() {
                    completion(.failure(.failedRequest))
                }
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async() {
                    completion(.failure(.invalidRequest))
                }
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }.resume()
    }
    
    // MARK: - Helper Methods
    
    private func didFetchCharactersList(data: Data?, response: URLResponse?, error: Error?, completion: CharactersListResult) {
        // Check if there is an error
        if error != nil {
            completion(.failure(.failedRequest))
        } else if let data = data, let response = response as? HTTPURLResponse {
            // Check HTTP code
            if response.statusCode == 200 {
                do {
                    // Create and configure JSON Decoder
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    // Decode JSON
                    let charactersList = try decoder.decode(CharactersList.self, from: data)

                    completion(.success(charactersList))
                } catch {
                    completion(.failure(.invalidRequest))
                }
            } else {
                completion(.failure(.failedRequest))
            }
        } else {
            completion(.failure(.unknown))
        }
    }
}
