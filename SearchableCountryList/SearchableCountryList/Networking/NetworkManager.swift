//
//  NetworkManager.swift
//  SearchableCountryList
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

