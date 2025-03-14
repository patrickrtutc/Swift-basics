//
//  ViewModelTests.swift
//  FirstProjectTests
//
//  Created by Patrick Tung on 2/19/25.
//

import XCTest
@testable import FirstProject

final class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!
        
        override func setUp() {
            super.setUp()
            viewModel = ViewModel()
        }
        
        override func tearDown() {
            viewModel = nil
            super.tearDown()
        }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Test for fully RFC 5322 compliant regex
    func testInvalidEmail() {
        
            let invalidEmails = [
                "plainaddress",
                "#@%^%#$@#$@#.com",
                "@example.com",
                "Joe Smith <email@example.com>",
                "email.example.com",
                "email@example@example.com",
                ".email@example.com",
                "email.@example.com",
                "email..email@example.com",
                "あいうえお@example.com",
                "email@example.com (Joe Smith)",
                "email@example",
                "email@-example.com",
                "email@example..com",
                "Abc..123@example.com",
                "\\”(),:;<>[\\]@example.com",
                "just”not”right@example.com",
                "this\\ is\"really\"not\\allowed@example.com"
            ]
            
            for email in invalidEmails {
                XCTAssertNotNil(viewModel.invalidEmail(email), "Expected '\(email)' to be invalid")
            }
        }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
