//
//  CharacterPresentable.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 27/12/20.
//

import Foundation

protocol CharacterPresentable {
    
    // MARK: - Properties
    
    var dataManager: DataManager { get }
    var name: String { get }
    var description: String { get }
    var image: Character.Image { get }
}
