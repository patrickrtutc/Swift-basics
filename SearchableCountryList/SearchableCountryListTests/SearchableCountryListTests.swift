//
//  SearchableCountryListTests.swift
//  SearchableCountryListTests
//
//  Created by Patrick Tung on 2/24/25.
//

import XCTest
@testable import SearchableCountryList

final class SearchableCountryListTests: XCTestCase {

    func testNetworkManager() async throws {
        
        // Test success case
        let testCountries = [
            MockCountryModel(name: "Australia", code: "AU"),
            MockCountryModel(name: "Brazil", code: "BR")
        ]
        let mockNetwork = MockNetworkManager(
            shouldSucceed: true,
            countries: testCountries
        )
        let url = URL(string: "https://example.com/countries")!

        do {
            let fetchedCountries: [MockCountryModel] = try await mockNetwork.fetch(
                from: url
            )
            assert(fetchedCountries == testCountries) // Should pass
        } catch {
            print("Unexpected error: \(error)") // Should not occur
        }

        // Test failure case
        let failingMock = MockNetworkManager(shouldSucceed: false)
        do {
            let _: [Country] = try await failingMock.fetch(from: url)
            assertionFailure("Fetch should have failed")
        } catch {
            assert(error is URLError) // Should pass
        }
    }

}
