//
//  ContentView.swift
//  SearchableCountryList
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

/// Main view displaying the list of countries with a search bar.
struct ContentView: View {
    @StateObject var viewModel = CountryListViewModel(networkManager: NetworkManager())

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView("Loading...")
                
            case .error(let error):
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding(.horizontal, 50)
                
            case .success:
                List(viewModel.filteredCountries, id: \.name) { country in
                    HStack(spacing: 15) {
                        // Flag image
                        AsyncImage(url: URL(string: country.flagPNG)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 5))

                        // Country details
                        VStack(alignment: .leading, spacing: 5) {
                            Text(country.name)
                                .font(.headline)
                            Text("Capital: \(country.capital)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Region: \(country.region)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Currency: \(country.currency.symbol ?? "Unknown")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
                .searchable(text: $viewModel.searchText)
                .navigationTitle("Countries")
            }
        }
        .task {
            await viewModel.fetchCountries()
        }
    }
}

#Preview {
    ContentView()
}
