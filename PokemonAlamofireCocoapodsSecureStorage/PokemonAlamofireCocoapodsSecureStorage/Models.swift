import Foundation

// MARK: - API Response Models

struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}

struct PokemonResult: Codable, Identifiable, Hashable {
    let name: String
    let url: String
    
    var id: Int {
        let urlString = url
        // Extract ID from URL string like "https://pokeapi.co/api/v2/pokemon/25/"
        if let lastPathComponent = urlString.split(separator: "/").last,
           let secondLastComponent = urlString.split(separator: "/").dropLast().last,
           secondLastComponent == "pokemon",
           let id = Int(lastPathComponent.isEmpty ? secondLastComponent : lastPathComponent) {
            return id
        } else {
            // Fallback to check if we can get ID from any number in the URL
            let components = urlString.split(separator: "/")
            for component in components.reversed() {
                if let id = Int(component) {
                    return id
                }
            }
        }
        return 0
    }
    
    // Image URLs for different sprites
    var spriteURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
    
    var officialArtworkURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
    
    // Required for Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PokemonResult, rhs: PokemonResult) -> Bool {
        return lhs.id == rhs.id
    }
} 