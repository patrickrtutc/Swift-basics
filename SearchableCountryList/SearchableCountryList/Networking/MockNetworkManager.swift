//
//  SwiftUIView.swift
//  SearchableCountryList
//
//  Created by Patrick Tung on 2/27/25.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    let shouldSucceed: Bool
    let countries: [MockCountryModel]
    
    init(shouldSucceed: Bool, countries: [MockCountryModel] = []) {
        self.shouldSucceed = shouldSucceed
        self.countries = countries
    }
    
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        if shouldSucceed {
            // Ensure the requested type T is [Country]
            guard T.self == [Country].self else {
                throw MockError.invalidType
            }
            return countries as! T
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

enum MockError: Error {
    case invalidType
}
