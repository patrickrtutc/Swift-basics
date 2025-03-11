//
//  NewMockManager.swift
//  DigimonAPISwiftUICombineTests
//
//  Created by Patrick Tung on 3/6/25.
//

import Foundation
@testable import DigimonAPISwiftUICombine
import Combine

final class NewMockManager: APIService {
    
    var shouldReturnError = false
    var testPath: String = ""


    func fetchData<T>(from url: String) -> AnyPublisher<T, any Error> where T : Decodable {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        
        // Use testPath if set; otherwise, fall back to the url parameter as the file name
        
//        let bundle = Bundle(for: MockAPIService.self)
        
        // Attempt to locate the JSON file in the bundle
        //        guard let urlObj = bundle.url(forResource: testPath, withExtension: "json") else {
        //            print("Error: Could not find \(testPath).json in test bundle")
        //            return Fail(error: URLError(.fileDoesNotExist))
        //                .eraseToAnyPublisher()
        //        }
        let bundle = Bundle(for: NewMockManager.self)
        guard let path = bundle.url(forResource: testPath, withExtension: "json") else{
            print("Error: Could not find \(testPath).json in test bundle")
            return Fail(error: URLError(.fileDoesNotExist))
                .eraseToAnyPublisher()
        }
        
        do {
            // Load and decode the JSON data
            let data = try Data(contentsOf: path)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            return Just(parsedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            print("Error decoding data from \(testPath).json: \(error)")
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
}
