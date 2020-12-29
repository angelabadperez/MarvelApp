//
//  CharacterViewModelTests.swift
//  MarvelAppTests
//
//  Created by Ángel Abad Pérez on 29/12/20.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import MarvelApp

class CharacterViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: CharacterPresentable!
    
    // MARK: -

    var scheduler: SchedulerType!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize Scheduler
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        
        // Initialize Sort Tap
        let sortTap = PublishSubject<Void>()
        
        // Initialize Mock Data Manager
        let mockDataManager = MockDataManager()
        
        // Initialize Characters Table View Model
        let charactersTableViewModel = CharactersTableViewModel(sortTap: sortTap, dataManager: mockDataManager)
        
        // Initialize View Model for a Single Character (for instance: 1)
        viewModel = charactersTableViewModel.viewModelForCharacter(at: 1)
    }

    override func tearDownWithError() throws { }

    // MARK: - Test for Name
    
    func testName() {
        XCTAssertEqual(viewModel.name, "A-Bomb (HAS)")
    }
    
    // MARK: - Test for Description
    
    func testDescription() {
        XCTAssertTrue(viewModel.description.contains("Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!"))
    }
    
    // MARK: - Test for Image
    
    func testImage() {
        XCTAssertEqual(viewModel.image.path, "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16")
        XCTAssertEqual(viewModel.image.imageExtension, "jpg")
    }

}
