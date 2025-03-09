//
//  CountryViewModel.swift
//  SearchableCountryList
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

enum CountryListViewState {
    case loading
    case success
    case error(Error)
}

/// ViewModel responsible for managing country data and search functionality.
class CountryListViewModel: ObservableObject {
    @Published var state: CountryListViewState
    
    @Published var searchText: String = "" {
        didSet {
            filterCountries()
        }
    }
    
    @Published var filteredCountries: [Country] = []
    
    /// Caching all countries
    private var allCountries: [Country] = []
    
    /// Encapsulate internal data
    private let networkManager: NetworkManagerProtocol

    /// Dependency Inversion to reduce coupling, default state to loading
    init(networkManager: NetworkManagerProtocol, state: CountryListViewState = .loading) {
        self.networkManager = networkManager
        self.state = state
    }

    func fetchCountries() async {
        do {
            guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else {
                throw URLError(.badURL)
            }
            /// Separate the network fetch (background) from the UI update (main thread):
            allCountries = try await networkManager.fetch(from: url)
            Task { @MainActor in
                filterCountries() /// Runs on main thread
                state = .success
            }
        } catch {
            state = .error(error)
        }
    }

    /// Filters countries based on the current search text.
    private func filterCountries() {
        if searchText.isEmpty {
            filteredCountries = allCountries
        } else {
            filteredCountries = allCountries.filter { $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
