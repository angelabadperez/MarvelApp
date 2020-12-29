//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 27/12/20.
//

import Foundation

class CharacterViewModel: CharacterPresentable {
    
    // MARK: - Properties
    
    let character: Character
    
    // MARK: - Initialization
    
    init(character: Character, dataManager: DataManager) {
        self.character = character
        self.dataManager = dataManager
    }
    
    // MARK: - Public API
    
    private(set) var dataManager: DataManager
    
    var name: String {
        return character.name
    }
    
    var description: String {
        return character.description
    }
    
    var image: Character.Image {
        return character.image
    }
}
