//
//  Repository.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 3/10/25.
//

import Foundation

// Protocol for the repository layer
protocol CountryRepositoryProtocol {
    func getCountries() async throws -> [Country]
}

// Implementation of the repository that uses NetworkManager
class CountryRepository: CountryRepositoryProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCountries() async throws -> [Country] {
        return try await networkManager.fetchCountries()
    }
    
    // Can add caching, local storage, or alternative data sources here
} 