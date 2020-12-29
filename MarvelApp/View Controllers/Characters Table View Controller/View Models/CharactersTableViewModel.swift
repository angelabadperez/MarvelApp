//
//  CharactersTableViewModel.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 27/12/20.
//

import RxSwift
import RxCocoa
import Foundation

class CharactersTableViewModel {
    
    // MARK: - Properties
    
    private let dataManager: DataManager
    
    // MARK: -
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfCharacters: Int {
        return charactersRelay.value.count
    }
    
    // MARK: -
    
    private(set) var offset: Int
    
    // MARK: -
    
    var sortDescDriver: Driver<Bool> {
        sortDescRelay.asDriver()
    }
    
    private let sortDescRelay = BehaviorRelay<Bool>(value: false)
    
    // MARK: -
    
    var charactersDriver: Driver<[Character]> {
        charactersRelay.asDriver()
    }
    
    private let charactersRelay = BehaviorRelay<[Character]>(value: [])
    
    // MARK: -
    
    var isLoadingDriver: Driver<Bool> {
        isLoadingRelay.asDriver()
    }
    
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    
    // MARK: -
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(sortTap: PublishSubject<Void>, dataManager: DataManager) {
        self.dataManager = dataManager
        self.offset = 0
        
        // Drive sort tap
        sortTap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.sortDescRelay.accept(!self.sortDescRelay.value)
                self.offset = 0
                self.charactersRelay.accept([])
                self.fetchData()
            })
            .disposed(by: disposeBag)
        
        // Fetch list of characters
        self.fetchData()
    }
    
    // MARK: - Public API
    
    func character(at index: Int) -> Character? {
        // Get character at given index
        guard index < charactersRelay.value.count else {
            return nil
        }
        
        return charactersRelay.value[index]
    }
    
    func viewModelForCharacter(at index: Int) -> CharacterPresentable? {
        // Get View Model for a concrete character
        guard let character = character(at: index) else {
            return nil
        }
        
        return CharacterViewModel(character: character, dataManager: dataManager)
    }
    
    func fetchData() {
        // Update loading relay
        isLoadingRelay.accept(true)
        
        dataManager.getCharactersList(offset: offset, sortDesc: sortDescRelay.value) { [weak self] result in
            guard let self = self else { return }
            
            // Update loading relay
            self.isLoadingRelay.accept(false)
            
            switch result {
            case .success(let charactersList):
                // Store offset
                self.offset += charactersList.count
                
                // Send characters list through the relay
                self.charactersRelay.accept(self.charactersRelay.value + charactersList.list)
            case .failure(let error): break // TODO
            }
        }
    }
}
