//
//  CountryListViewModel.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 2/28/25.
//

import Foundation
import Combine

class CountryListViewModel: ObservableObject {
    // Published properties for reactive updates
    @Published var searchText: String = ""
    @Published var filteredCountries: [Country] = []
    
    // Private properties
    private var allCountries: [Country] = []
    private let networkManager: NetworkManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        setupBindings()
    }
    
    // Fetch countries from the network
    func fetchCountries() {
        networkManager.fetchCountries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching countries: \(error)")
                }
            }, receiveValue: { [weak self] countries in
                self?.allCountries = countries
                self?.filteredCountries = countries
            })
            .store(in: &cancellables)
    }
    
    // Set up Combine bindings for search filtering
    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main) // Reduce filtering frequency
            .removeDuplicates() // Avoid redundant updates
            .sink { [weak self] searchText in
                self?.filterCountries(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    // Filter countries based on search text
    private func filterCountries(with searchText: String) {
        if searchText.isEmpty {
            filteredCountries = allCountries // Show all countries if search is empty
        } else {
            filteredCountries = allCountries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
