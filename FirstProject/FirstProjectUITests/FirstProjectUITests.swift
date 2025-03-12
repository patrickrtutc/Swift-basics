//
//  FirstProjectUITests.swift
//  FirstProjectUITests
//
//  Created by Patrick Tung on 2/19/25.
//

import XCTest

final class FirstProjectUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func test_ButtonSignIn_EnabledWithValidEmailAndPassword() {
        app = XCUIApplication()
        app.launch()
        let emailField = app.textFields["E-mail"]
        let passwordField = app.textFields["Password"]
        let signInButton = app.buttons["Sign In"]
        
        emailField.tap()
        emailField.typeText("test@example.com")
        
        passwordField.tap()
        passwordField.typeText("Password1!")
        
        signInButton.tap()
        
        XCTAssertTrue(signInButton.isEnabled, "Sign-In button should be enabled after entering valid credentials")
            }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
