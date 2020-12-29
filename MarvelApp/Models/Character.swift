//
//  Character.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import Foundation

struct Character: Decodable {
    
    // MARK: - Decodable Protocol
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case image = "thumbnail"
    }
    
    // MARK: - Internal Types
    
    struct Image: Decodable {
        
        // MARK: - Decodable Protocol
        
        enum CodingKeys: String, CodingKey {
            case path
            case imageExtension = "extension"
        }
        
        // MARK: - Internal Types
        
        enum Sizes: String {
            case portrait = "portrait_medium"
            case landscape = "landscape_medium"
            case square = "standard_medium"
        }
        
        // MARK: - Properties
        
        let path: String
        let imageExtension: String
    }
    
    // MARK: - Properties
    
    let name: String
    let description: String
    let image: Image
}
