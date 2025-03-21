//
//  ContentView.swift
//  AmericanAirlinesCodingChallenge
//
//  Created by Patrick Tung on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar
                
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView().padding()
                    } else if !viewModel.hasSearched && viewModel.searchQuery.isEmpty {
                        emptyStateView(
                            icon: "magnifyingglass.circle",
                            title: "Enter a search term to get started"
                        )
                    } else if viewModel.hasSearched && viewModel.results.isEmpty && viewModel.directTopics.isEmpty && !viewModel.searchQuery.isEmpty {
                        emptyStateView(
                            icon: "magnifyingglass.circle",
                            title: "No results found",
                            subtitle: "Try different search terms"
                        )
                    } else {
                        resultsSections
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Components
    
    private var searchBar: some View {
        HStack {
            TextField("Search", text: $viewModel.searchQuery)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.trailing, 8)
                .focused($isSearchFieldFocused)
                .submitLabel(.search)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onSubmit(viewModel.search)
            
            if !viewModel.searchQuery.isEmpty {
                Button(action: viewModel.clearSearch) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            }
            
            Button("Search") {
                viewModel.search()
                isSearchFieldFocused = false
            }
            .foregroundColor(.blue)
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    private var resultsSections: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Results section
            if !viewModel.uniqueResults.isEmpty {
                sectionHeader("RESULTS")
                
                ForEach(viewModel.uniqueResults) { result in
                    ResultItemView(
                        title: viewModel.extractTitle(from: result.text),
                        url: result.firstURL
                    )
                    .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                }
            }
            
            // Related Topics section
            if !viewModel.directTopics.isEmpty {
                sectionHeader("RELATED TOPICS")
                    .padding(.top, 16)
                
                ForEach(viewModel.directTopics) { topic in
                    TopicItemView(
                        title: viewModel.extractTitle(from: topic.text),
                        url: topic.firstURL
                    )
                    .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                }
            }
        }
    }
    
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 4)
    }
    
    private func emptyStateView(icon: String, title: String, subtitle: String? = nil) -> some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.7))
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
        .padding(.top, 100)
        .padding(.bottom, 40)
    }
}

#Preview {
    ContentView()
}
