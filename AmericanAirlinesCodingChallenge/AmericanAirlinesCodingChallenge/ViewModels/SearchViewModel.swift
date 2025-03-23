import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var results: [Result] = []
    @Published var relatedTopics: [RelatedTopic] = []
    @Published var abstract: String = ""
    @Published var heading: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasSearched = false
    
    // Computed property to filter out duplicate results based on normalized URL
    var uniqueResults: [Result] {
        var uniqueURLs = Set<String>()
        var uniqueTitles = Set<String>()
        
        // Print out all results for debugging
        for (index, result) in results.enumerated() {
            let title = extractTitle(from: result.text)
            let normalizedURL = normalizeURL(result.firstURL)
            print("Result \(index): URL=\(normalizedURL), Title=\(title)")
        }
        
        return results.filter { result in
            // Extract title
            let title = extractTitle(from: result.text)
            
            // Normalize URL by removing trailing slashes and common variations
            let normalizedURL = normalizeURL(result.firstURL)
            
            // Check if this is a duplicate based on normalized URL or title
            let isUnique = !uniqueURLs.contains(normalizedURL) && !uniqueTitles.contains(title)
            
            if isUnique {
                uniqueURLs.insert(normalizedURL)
                uniqueTitles.insert(title)
            } else {
                print("Filtering out duplicate: \(title) - \(normalizedURL)")
            }
            
            return isUnique
        }
    }
    
    // Computed property to get only direct topics (not categories)
    var directTopics: [DirectTopic] {
        var topics: [DirectTopic] = []
        
        for topic in relatedTopics {
            switch topic {
            case .topic(let directTopic):
                topics.append(directTopic)
            case .category:
                // Skip categories as requested
                continue
            }
        }
        
        return topics
    }
    
    // Helper function to normalize URLs for comparison
    private func normalizeURL(_ url: String) -> String {
        var normalized = url.lowercased()
        
        // Remove trailing slash if present
        if normalized.hasSuffix("/") {
            normalized.removeLast()
        }
        
        // Remove http/https and www prefixes for comparison
        normalized = normalized
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
        
        if normalized.hasPrefix("www.") {
            normalized.removeFirst(4)
        }
        
        return normalized
    }
    
    private let searchService: SearchServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Dependency injection via initializer
    init(searchService: SearchServiceProtocol = SearchService()) {
        self.searchService = searchService
    }
    
    func search() {
        guard !searchQuery.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        // Trim whitespace and clean up the query
        let trimmedQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Update the UI with the trimmed query
        searchQuery = trimmedQuery
        
        searchService.search(for: trimmedQuery)
            .sink { completion in
                self.isLoading = false
                self.hasSearched = true
                
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("Error: \(error)")
                }
            } receiveValue: { response in
                self.results = response.results
                self.relatedTopics = response.relatedTopics
                self.abstract = response.abstract
                self.heading = response.heading
                self.hasSearched = true
                
                // Debug
                print("Found \(self.results.count) results")
                print("Found \(self.uniqueResults.count) unique results")
                print("Found \(self.relatedTopics.count) related topics")
                print("Found \(self.directTopics.count) direct topics (without categories)")
                
                // Print the related topics structure for debugging
                for (index, topic) in self.relatedTopics.enumerated() {
                    switch topic {
                    case .topic(let directTopic):
                        print("Topic \(index): \(directTopic.text)")
                    case .category(let categoryTopic):
                        print("Category \(index): \(categoryTopic.name) with \(categoryTopic.topics.count) topics")
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func clearSearch() {
        searchQuery = ""
        results = []
        relatedTopics = []
        abstract = ""
        heading = ""
        errorMessage = nil
        hasSearched = false
    }
    
    // Helper method to extract a title from HTML text
    func extractTitle(from text: String) -> String {
        if text.contains("<a href=") {
            if let range = text.range(of: ">") {
                let afterOpenTag = text[range.upperBound...]
                if let closeRange = afterOpenTag.range(of: "<") {
                    return String(afterOpenTag[..<closeRange.lowerBound])
                }
            }
        }
        
        // If there's a dash with description, extract just the title
        if let range = text.range(of: " - ") {
            return String(text[..<range.lowerBound])
        }
        
        return text
    }
} 
