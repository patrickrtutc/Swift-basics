//
//  MockAPIServiceManager.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/4/25.
//

import Combine
import Foundation

class MockAPIService: APIService {
    
    var shouldReturnError = false
    var testPath: String = ""
    
    func fetchData<T>(from url: String) -> AnyPublisher<T, any Error> where T : Decodable {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        let bundle = Bundle(for: MockAPIService.self)
        let urlObj = bundle.url(forResource: testPath, withExtension: "json")
        guard let urlObj = urlObj else{
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: urlObj)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            return Just(parsedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()

        }
        
//        
//        guard let url = Bundle(for: MockAPIService.self).url(forResource: "mockDigimon", withExtension: "json") else {
//            print("Error: Could not find mockDigimon.json in test bundle")
//            return Fail(error: URLError(.fileDoesNotExist))
//                .eraseToAnyPublisher()
//        }
//        
//        print("URL found: \(url)")
//        do {
//            let data = try Data(contentsOf: url)
//            let digimons = try JSONDecoder().decode([Digimon].self, from: data)
//            print("Mock data loaded successfully: \(digimons.count) Digimons")
//            return Just(digimons)
//                .setFailureType(to: Error.self)
//                .eraseToAnyPublisher()
//        } catch {
//            print("Error decoding mock data: \(error)")
//            return Fail(error: error)
//                .eraseToAnyPublisher()
//        }
    }

    
}
