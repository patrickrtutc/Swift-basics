//
//  ApiService.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/5/25.
//

import SwiftUI
import Foundation
import Combine

protocol APIService{
    func fetchData<T: Decodable>(from url:String) -> AnyPublisher<T, Error>
}

struct APIServiceManager : APIService {
    func fetchData<T>(from url: String) -> AnyPublisher<T, any Error> where T : Decodable {
        guard let urlObj = URL(string: url) else{
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: urlObj)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
                    throw URLError(.badServerResponse)
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

