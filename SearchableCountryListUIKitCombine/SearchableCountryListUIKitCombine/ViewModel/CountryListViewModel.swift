//
//  CountryListViewModel.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 2/28/25.
//

import Foundation
import Combine

@MainActor
class CountryListViewModel: ObservableObject {
    // Published properties for reactive updates
    @Published var searchText: String = ""
    @Published var filteredCountries: [Country] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Private properties
    private var allCountries: [Country] = []
    private let repository: CountryRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var fetchTask: Task<Void, Never>?
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
        setupBindings()
    }
    
    deinit {
        fetchTask?.cancel()
    }
    
    // Fetch countries from the repository using async/await
    func fetchCountries() {
        // Cancel any existing fetch task
        fetchTask?.cancel()
        
        // Create a new fetch task
        fetchTask = Task {
            do {
                isLoading = true
                errorMessage = nil
                
                let countries = try await repository.getCountries()
                
                // Update the UI on the main thread
                allCountries = countries
                filterCountries(with: searchText)
                isLoading = false
            } catch {
                errorMessage = "Failed to load countries: \(error.localizedDescription)"
                isLoading = false
                print("Error fetching countries: \(error)")
            }
        }
    }
    
    // Set up Combine bindings for search filtering
    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.filterCountries(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    // Filter countries based on search text
    private func filterCountries(with searchText: String) {
        if searchText.isEmpty {
            filteredCountries = allCountries
        } else {
            filteredCountries = allCountries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
