//
//  SearchableCountryListUITests.swift
//  SearchableCountryListUITests
//
//  Created by Patrick Tung on 2/24/25.
//

import XCTest

final class SearchableCountryListUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

    @MainActor
    func testCountryListAppears() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let countrylistCollectionView = XCUIApplication()/*@START_MENU_TOKEN@*/.collectionViews["countryList"]/*[[".collectionViews[\"Sidebar\"]",".collectionViews[\"countryList\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(countrylistCollectionView.waitForExistence(timeout: 5))
    }
    
    @MainActor
    func testCountryListCellAppears() throws {
        let app = XCUIApplication()
        app.launch()
        let countrylistCollectionView = XCUIApplication()/*@START_MENU_TOKEN@*/.collectionViews["countryList"]/*[[".collectionViews[\"Sidebar\"]",".collectionViews[\"countryList\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let cell = countrylistCollectionView.firstMatch.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }

    func testCountryListNavigationBarAppears() throws {
        let app = XCUIApplication()
        app.launch()
        let countriesNavigationBar = XCUIApplication()/*@START_MENU_TOKEN@*/.navigationBars["Countries"]/*[[".otherElements[\"countryListNavigationBar\"].navigationBars[\"Countries\"]",".navigationBars[\"Countries\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(countriesNavigationBar.waitForExistence(timeout: 5))
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
