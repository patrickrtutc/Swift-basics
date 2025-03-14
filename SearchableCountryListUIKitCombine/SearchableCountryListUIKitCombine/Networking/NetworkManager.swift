//
//  NetworkManager.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 2/28/25.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCountries<T: Decodable>() async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    func fetchCountries<T: Decodable>() async throws -> T {
        guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
