import Foundation
import Alamofire
import CoreData

class PokemonService {
    static let shared = PokemonService()
    
    private let baseURL = "https://pokeapi.co/api/v2"
    
    func fetchPokemons(offset: Int = 0, limit: Int = 40) async throws -> PokemonResponse {
        let url = "\(baseURL)/pokemon?offset=\(offset)&limit=\(limit)"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url)
                .validate()
                .responseDecodable(of: PokemonResponse.self) { response in
                    switch response.result {
                    case .success(let pokemonResponse):
                        // Debug logging
                        print("API Response: \(pokemonResponse.results.count) results")
                        for (index, pokemon) in pokemonResponse.results.enumerated() {
                            print("API Result \(index): \(pokemon.name), URL: \(pokemon.url), ID: \(pokemon.id)")
                        }
                        continuation.resume(returning: pokemonResponse)
                    case .failure(let error):
                        print("API Error: \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    // Save Pokemon to Core Data
    @MainActor
    func savePokemonsToStorage(results: [PokemonResult]) {
        let context = PersistenceController.shared.container.viewContext
        
        // Delete existing Pokemon data if needed
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Pokemon")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            
            // Save new Pokemon data
            for result in results {
                let pokemon = Pokemon(context: context)
                pokemon.id = Int64(result.id)
                pokemon.name = result.name
                pokemon.url = result.url
                
                print("Saving Pokemon: \(result.name) with ID: \(result.id)")
            }
            
            try context.save()
            print("Successfully saved \(results.count) Pokemon to Core Data")
        } catch {
            print("Failed to save Pokemon data: \(error)")
        }
    }
    
    // Fetch Pokemon from Core Data
    @MainActor
    func fetchPokemonsFromStorage() -> [PokemonResult] {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)]
        
        do {
            let pokemons = try context.fetch(fetchRequest)
            print("Fetched \(pokemons.count) Pokemon from Core Data")
            
            return pokemons.compactMap { pokemon in
                guard let name = pokemon.name, let url = pokemon.url else {
                    print("Invalid Pokemon data")
                    return nil
                }
                
                let result = PokemonResult(name: name, url: url)
                print("Loaded Pokemon: \(result.name) with ID: \(result.id)")
                return result
            }
        } catch {
            print("Failed to fetch Pokemon data: \(error)")
            return []
        }
    }
} 
