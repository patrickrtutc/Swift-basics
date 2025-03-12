//
//  Data.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//

import SwiftUI

// Product model
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let image: String // Placeholder for image name
    let category: String
}

// Cart item model
struct CartItem {
    let product: Product
    var quantity: Int
}

// Cart model with immutable operations
struct Cart {
    var items: [CartItem] = []
    
    // Adds a product, returning a new Cart instance
    func addingProduct(_ product: Product) -> Cart {
        var newItems = items
        if let index = newItems.firstIndex(where: { $0.product.id == product.id }) {
            newItems[index].quantity += 1
        } else {
            newItems.append(CartItem(product: product, quantity: 1))
        }
        return Cart(items: newItems)
    }
    
    // Computes total price
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
    }
}
