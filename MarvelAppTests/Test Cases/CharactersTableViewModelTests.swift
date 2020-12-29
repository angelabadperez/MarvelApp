//
//  CharactersTableViewModelTests.swift
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

class CharactersTableViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: CharactersTableViewModel!
    
    // MARK: -

    var scheduler: SchedulerType!

    // MARK: -

    var sortTap: PublishSubject<Void>!

    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        // Initialize Scheduler
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        
        // Initialize Sort Tap
        sortTap = PublishSubject<Void>()
        
        // Initialize Mock Data Manager
        let mockDataManager = MockDataManager()
        
        // Initialize View Model
        viewModel = CharactersTableViewModel(sortTap: sortTap, dataManager: mockDataManager)
    }

    override func tearDownWithError() throws { }

    // MARK: - Test for Number of Sections
    
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    // MARK: - Test for Number of Characters
    
    func testNumberOfCharacters() {
        XCTAssertEqual(viewModel.numberOfCharacters, 20)
    }
    
    // MARK: - Test for Offset
    
    func testOffset() {
        XCTAssertEqual(viewModel.offset, 20)
    }
    
    // MARK: - Test for Characters Driver
    
    func testCharactersDriver_HasCharacters() {
        // Create Subscription
        let observable = viewModel.charactersDriver.asObservable().subscribeOn(scheduler)

        // Fetch Result
        let result: [Character] = try! observable.toBlocking().first()!

        // Assertions
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 20)
    }
    
    // MARK: - Tests for Character At Index
    
    func testCharacterAtIndex_NotNil() {
        // Create Subscription
        let observable = viewModel.charactersDriver.asObservable().subscribeOn(scheduler)

        // Fetch Result
        let _ = try! observable.toBlocking().first()!
        
        // Fetch Character
        let result = viewModel.character(at: 0)
        
        // Assertions
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.name, "3-D Man")
    }
    
    func testCharacterAtIndex_Nil() {
        // Create Subscription
        let observable = viewModel.charactersDriver.asObservable().subscribeOn(scheduler)

        // Fetch Result
        let _ = try! observable.toBlocking().first()!
        
        // Fetch Character
        let result = viewModel.character(at: 21)
        
        // Assertions
        XCTAssertNil(result)
    }
    
    // MARK: - Tests for Sort Descendent
    
    func testSortDesc_False() {
        // Create Subscription
        let observable = viewModel.sortDescDriver.asObservable().subscribeOn(scheduler)
        
        // Fetch Result
        let result = try! observable.toBlocking().first()!
        
        // Assertions
        XCTAssertFalse(result)
    }
    
    func testSortDesc_True() {
        // Emit onNext on sortTap
        sortTap.onNext(())
        
        // Create Subscription
        let observable = viewModel.sortDescDriver.asObservable().subscribeOn(scheduler)
        
        // Fetch Result
        let result = try! observable.toBlocking().first()!
        
        // Assertions
        XCTAssertTrue(result)
    }
    
    // MARK: - Tests for Loading Driver
    
    func testIsLoading_False() {
        // Create Subscription
        let observable = viewModel.isLoadingDriver.asObservable().subscribeOn(scheduler)
        
        // Fetch Result
        let result = try! observable.toBlocking().first()!
        
        // Assertions
        XCTAssertFalse(result)
    }
    
}
