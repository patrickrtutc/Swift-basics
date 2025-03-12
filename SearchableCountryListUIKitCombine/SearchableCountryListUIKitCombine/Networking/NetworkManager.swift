//
//  NetworkManager.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 2/28/25.
//

import Foundation
import Combine
import Foundation

protocol NetworkManagerProtocol {
    func fetchCountries<T: Decodable>() -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkManagerProtocol {
    func fetchCountries<T: Decodable>() -> AnyPublisher<T, Error> {
        guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
