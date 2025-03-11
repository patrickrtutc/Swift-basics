//
//  DigimonViewModel.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/4/25.
//

import SwiftUI
import Combine

extension SearchableDigimonListView {
    
    @Observable
    class ViewModel: ObservableObject {

        var searchText: String = ""
        var state: ViewState = .idle
        
        private let coreDataManager: CoreDataManager
        private let apiService: APIService
        private var cancellables = Set<AnyCancellable>()
        
        init(apiService: APIService, coreDataManager: CoreDataManager = .shared) {
            self.apiService = apiService
            self.coreDataManager = coreDataManager
        }
        
        var filteredDigimons: [Digimon] {
            guard let digimons = state.getDigimon() else { return [] }
            return searchText.isEmpty ? digimons : digimons.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        func fetchDigimons() {
            state = .loading
//            print("Reloaded!!!")

            
            let cachedDigimons = coreDataManager.fetchDigimons()
                    if !cachedDigimons.isEmpty {
                        state = .loaded(cachedDigimons)
                        return
                    }
            
            print("Reloaded!!!")
            
            
            apiService.fetchData(from: APIEndpoints.digimon)
                .receive(on: DispatchQueue.main) // Ensure updates occur on the main thread
                .sink(receiveCompletion: {[weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.state = .error(error)
                    case .finished:
                        break
                    }
                }, receiveValue: {[weak self] digimons in
                    self?.coreDataManager.saveDigimons(digimons)
                    self?.state = .loaded(digimons)
                })
                .store(in: &cancellables)
        }
    }

}
