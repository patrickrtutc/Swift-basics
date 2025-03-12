//
//  ContentView.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var cart = Cart()
    
    let productService: ProductService = MockProductService()
    
    var body: some View {
        TabView {
            
            HomeView(productService: productService, cart: $cart)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoritesView().tabItem {
                Label("Favorites", systemImage: "heart")
            }
            
            CartView(cart: $cart)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
