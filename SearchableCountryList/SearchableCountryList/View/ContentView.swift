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
                ProgressView("Loading...").accessibilityIdentifier("loadingIndicator")

            case .error(let error):
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding(.horizontal, 50)
                    .accessibilityIdentifier("errorMessage")
                
            case .success:
                List(viewModel.filteredCountries, id: \.name) { country in
                    CountryListItem(country: country)
                }
                .searchable(text: $viewModel.searchText)
                .navigationTitle("Countries")
                .accessibilityIdentifier("countryList")
            }
        }
        .task {
            await viewModel.fetchCountries()
        }
    }
}

/// View representing a single country item in the list.
struct CountryListItem: View {
    let country: Country
    
    var body: some View {
        HStack(spacing: 15) {
            // Flag image loaded asynchronously
            AsyncImage(url: URL(string: country.flagPNG)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 30)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            // Country details in a vertical stack
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
}

#Preview {
    ContentView()
}
