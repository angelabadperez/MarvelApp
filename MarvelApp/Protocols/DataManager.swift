//
//  DataManager.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 27/12/20.
//

import Foundation

protocol DataManager {
    
    // MARK: - Type Aliases
    
    typealias CharactersListResult = (Result<CharactersList, MarvelError>) -> Void
    typealias ImageResult = (Result<Data, MarvelError>) -> Void
    
    // MARK: - Methods
    
    func getCharactersList(offset: Int, sortDesc: Bool, completion: @escaping CharactersListResult)
    func downloadImage(url: URL, completion: @escaping ImageResult)
}
