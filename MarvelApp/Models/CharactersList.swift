//
//  CharactersList.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import Foundation

struct CharactersList: Decodable {
    
    // MARK: - Decodable Protocol
    
    enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case count
        case list = "results"
    }
    
    // MARK: - Properties
    
    let offset: Int
    let limit: Int
    let count: Int
    let list: [Character]
    
    // MARK: - Initialization
    
    init(from decoder: Decoder) throws {
        // Containers
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let nestedContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        // Offset, limit and count
        self.offset = try nestedContainer.decode(Int.self, forKey: CodingKeys.offset)
        self.limit = try nestedContainer.decode(Int.self, forKey: CodingKeys.limit)
        self.count = try nestedContainer.decode(Int.self, forKey: CodingKeys.count)
        
        // List of characters
        self.list = try nestedContainer.decode([Character].self, forKey: CodingKeys.list)
    }
}
