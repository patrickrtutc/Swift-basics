//
//  ContentView.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/4/25.
//

import SwiftUI

struct SearchableDigimonListView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .idle:
                    //                    Text("Start searching for Digimon")
                    Color.clear.onAppear { viewModel.fetchDigimons() }
                case .loading:
                    ProgressView("Loading Digimons...")
                case .loaded:
                    List(viewModel.filteredDigimons, id: \.name) { digimon in
                        HStack {
                            DigimonRow(digimon: digimon)
                        }
                    }
                case .error(let message):
                    VStack {
                        Text("Error: \(message)").foregroundColor(.red)
                        Button("Retry") {
                            viewModel.fetchDigimons()
                        }
                    }
                }
            }
            .navigationTitle("Digimon List")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .onAppear {
                viewModel.fetchDigimons()
            }
            .refreshable {
                viewModel.fetchDigimons()
            }
        }
    }
}
