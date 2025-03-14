//
//  CountryDetailView.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 3/10/25.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with flag and name
                HStack {
                    AsyncImage(url: URL(string: country.flagPNG)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 64, height: 48)
                    .cornerRadius(4)
                    .shadow(radius: 2)
                    
                    Text(country.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding(.top, 20)
                
                // Basic Information Section
                GroupBox("Basic Information") {
                    InfoRow(title: "Capital", value: country.capital)
                    InfoRow(title: "Region", value: country.region)
                    InfoRow(title: "Country Code", value: country.code)
                }
                
                // Currency Section
                GroupBox("Currency") {
                    InfoRow(title: "Name", value: country.currency.name ?? "N/A")
                    InfoRow(title: "Code", value: country.currency.code ?? "N/A")
                    InfoRow(title: "Symbol", value: country.currency.symbol ?? "N/A")
                }
                
                // Language Section
                GroupBox("Language") {
                    InfoRow(title: "Name", value: country.language.name ?? "N/A")
                    InfoRow(title: "Code", value: country.language.code ?? "N/A")
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationView {
        CountryDetailView(country: Country(
            name: "United States",
            code: "US",
            capital: "Washington, D.C.",
            flag: "🇺🇸",
            region: "Americas",
            currency: Country.Currency(code: "USD", name: "US Dollar", symbol: "$"),
            language: Country.Language(code: "en", name: "English")
        ))
    }
} 