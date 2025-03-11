//
//  DigimonAPISwiftUICombineTests.swift
//  DigimonAPISwiftUICombineTests
//
//  Created by Patrick Tung on 3/4/25.
//

import XCTest
import Combine
@testable import DigimonAPISwiftUICombine // Replace with your app's module name

class DigimonAPISwiftUICombineTests: XCTestCase {
    var viewModel: SearchableDigimonListView.ViewModel!
    var mockService: NewMockManager!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        mockService = NewMockManager()
        viewModel = SearchableDigimonListView.ViewModel(apiService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
        // Arrange
        mockService.testPath = "mockDigimon" // Set the test path to match the JSON file name
        let expectation = expectation(description: "Fetch data succeeds with valid JSON")
        
        // Act
        viewModel.fetchDigimons()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.digimons.count, 209)
            
            expectation.fulfill()
            
        }
        //         Assert
        //        viewModel.$state
        //            .dropFirst()
        //            .sink { state in
        //                if case .loaded = state {
        ////                    expectation.fulfill()
        //                }
        //            }
        //            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
        
        //        mockService.fetchData(from: ApiEndpoints.digimon)
        //            .sink(receiveCompletion: { completion in
        //                switch completion {
        //                case .finished:
        //                    break
        //                case .failure(let error):
        //                    XCTFail("Expected success, but got error: \(error)")
        //                }
        //            }, receiveValue: { (digimons:[Digimon]) in
        //                // Assert
        //                XCTAssertEqual(digimons.count, 1, "Expected 1 Digimon from mock data")
        //                XCTAssertEqual(digimons.first?.name, "Agumon", "Expected Digimon name to be Agumon")
        //                expectation.fulfill()
        //            })
        //            .store(in: &cancellables)
        
        // Wait for the expectation
        //        wait(for: [expectation], timeout: 2.0)
    }
    
    func testViewModelFetchDigimonsError() {
        // Arrange
        mockService.shouldReturnError = true
        let expectation = expectation(description: "Fetch Digimons Fails")
        
        // Act
        viewModel.fetchDigimons()
        
        // Assert
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .error = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
        
        if case .error(let message) = viewModel.state {
            XCTAssertEqual(message, URLError(.badServerResponse).localizedDescription)
        } else {
            XCTFail("Expected error state")
        }
        XCTAssertTrue(viewModel.digimons.isEmpty)
    }
}
