//
//  MockDataManager.swift
//  MarvelAppTests
//
//  Created by Ángel Abad Pérez on 29/12/20.
//

import Foundation
@testable import MarvelApp

class MockDataManager: DataManager {

    func getCharactersList(offset: Int, sortDesc: Bool, completion: @escaping CharactersListResult) {
        // Obtain Reference to Bundle
        let bundle = Bundle(for: type(of: self))
        
        // Ask Bundle for URL of Stub
        let url = bundle.url(forResource: "characters", withExtension: "json")
        
        // Use URL to Create Data Object
        let data = try! Data(contentsOf: url!)
        
        // Create JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            // Decode JSON
            let charactersList = try decoder.decode(CharactersList.self, from: data)
            
            completion(.success(charactersList))
        } catch {
            completion(.failure(.unknown))
        }
        
    }
    
    func downloadImage(url: URL, completion: @escaping ImageResult) { }
}
