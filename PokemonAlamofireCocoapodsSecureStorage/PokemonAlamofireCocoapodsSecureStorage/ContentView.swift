//
//  ContentView.swift
//  PokemonAlamofireCocoapodsSecureStorage
//
//  Created by Patrick Tung on 3/19/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var pokemons: [PokemonResult] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var isShowingError = false
    @State private var selectedPokemon: PokemonResult?
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pokemons, id: \.id) { pokemon in
                    PokemonRowView(pokemon: pokemon)
                        .onTapGesture {
                            selectedPokemon = pokemon
                            showingDetail = true
                        }
                }
            }
            .navigationTitle("Pokemon")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            await fetchPokemonsFromAPI()
                        }
                    }) {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    }
                    .disabled(isLoading)
                }
            }
            .overlay {
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                }
            }
            .sheet(isPresented: $showingDetail) {
                if let pokemon = selectedPokemon {
                    PokemonDetailView(pokemon: pokemon)
                }
            }
            .alert("Error", isPresented: $isShowingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage ?? "Unknown error occurred")
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        // First try to load from Core Data
        let storedPokemons = PokemonService.shared.fetchPokemonsFromStorage()
        
        if !storedPokemons.isEmpty {
            self.pokemons = storedPokemons
        } else {
            // If no stored data, fetch from API
            Task {
                await fetchPokemonsFromAPI()
            }
        }
    }
    
    private func fetchPokemonsFromAPI() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await PokemonService.shared.fetchPokemons()
            
            await MainActor.run {
                // Print for debugging
                for (index, result) in response.results.enumerated() {
                    print("Pokemon \(index): \(result.name) with ID: \(result.id)")
                }
                
                self.pokemons = response.results
            }
            
            // Save to Core Data
            await PokemonService.shared.savePokemonsToStorage(results: response.results)
        } catch {
            errorMessage = error.localizedDescription
            isShowingError = true
        }
    }
}

struct PokemonRowView: View {
    let pokemon: PokemonResult
    
    var body: some View {
        HStack {
            // Pokemon sprite image
            AsyncImage(url: pokemon.spriteURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 60, height: 60)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("#\(pokemon.id)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(pokemon.name.capitalized)
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
        .id(pokemon.id) // Force uniqueness with explicit ID
    }
}

struct PokemonDetailView: View {
    let pokemon: PokemonResult
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Pokemon official artwork (larger image)
                    AsyncImage(url: pokemon.officialArtworkURL) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Color.gray.opacity(0.1)
                                    .frame(height: 200)
                                ProgressView()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        case .failure:
                            ZStack {
                                Color.gray.opacity(0.2)
                                    .frame(height: 200)
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.gray)
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Pokemon #\(pokemon.id)")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        Divider()
                        
                        HStack {
                            Text("API URL:")
                                .fontWeight(.semibold)
                            
                            Text(pokemon.url)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationTitle(pokemon.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
