//
//  HomeView.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//
import SwiftUI

struct HomeView: View {
    @State private var products: [Product] = []
    @State private var searchText: String = ""
    @State private var selectedCategory: String? = nil
    let productService: ProductService
    @Binding var cart: Cart
    
    // Computed view model based on current state
    var viewModel: HomeViewModel {
        HomeViewModel(products: products, searchText: searchText, selectedCategory: selectedCategory)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                TextField("Search Furniture", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Category filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        Button("All") { selectedCategory = nil }
                            .buttonStyle(CategoryButtonStyle(isSelected: selectedCategory == nil))
                        Button("Chair") { selectedCategory = "Chair" }
                            .buttonStyle(CategoryButtonStyle(isSelected: selectedCategory == "Chair"))
                        Button("Sofa") { selectedCategory = "Sofa" }
                            .buttonStyle(CategoryButtonStyle(isSelected: selectedCategory == "Sofa"))
                    }
                    .padding(.horizontal)
                }
                
                // Product list
                List(viewModel.filteredProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: product, cart: $cart)) {
                        ProductRow(product: product)
                    }
                }
            }
            .navigationTitle("Find the Best Furniture!")
        }
        .onAppear {
            products = productService.getProducts()
        }
    }
}

// Helper view for product row
struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            Image(product.image) // In a real app, use proper image loading
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

// Custom button style for categories
struct CategoryButtonStyle: ButtonStyle {
    let isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isSelected ? Color.brown.opacity(0.2) : Color.gray.opacity(0.1))
            .foregroundColor(isSelected ? .brown : .gray)
            .cornerRadius(20)
    }
}
