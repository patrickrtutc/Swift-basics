import Foundation
import Combine

// Protocol defining the interface for search services
protocol SearchServiceProtocol {
    func search(for query: String) -> AnyPublisher<DuckDuckGoResponse, Error>
}

class SearchService: SearchServiceProtocol {
    func search(for query: String) -> AnyPublisher<DuckDuckGoResponse, Error> {
        // Clean and encode the query
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Use URLComponents to properly handle the encoding
        var components = URLComponents(string: APIEndpoints.urlString)!
        components.queryItems = [
            URLQueryItem(name: "q", value: trimmedQuery),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "pretty", value: "1")
        ]
        
        guard let url = components.url else {
            print("Error: Failed to create URL for query: \(query)")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        print("Making request to URL: \(url.absoluteString)")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                // Debug: print the JSON response for troubleshooting
                #if DEBUG
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("API Response: \(jsonString.prefix(200))...") // Print just the start to avoid console overflow
                }
                #endif
                
                return data
            }
            .decode(type: DuckDuckGoResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
} 
