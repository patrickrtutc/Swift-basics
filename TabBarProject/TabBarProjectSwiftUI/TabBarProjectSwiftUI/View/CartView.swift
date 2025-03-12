//
//  CartView.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//

import SwiftUI

struct CartView: View {
    @Binding var cart: Cart
    
    var body: some View {
        NavigationView {
            VStack {
                if cart.items.isEmpty {
                    Text("Your cart is empty")
                        .foregroundColor(.gray)
                } else {
                    List(cart.items, id: \.product.id) { item in
                        HStack {
                            Text(item.product.name)
                            Spacer()
                            Text("x\(item.quantity)")
                            Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
                                .foregroundColor(.brown)
                        }
                    }
                    Text("Total: $\(cart.totalPrice, specifier: "%.2f")")
                        .font(.headline)
                        .padding()
                }
            }
            .navigationTitle("Cart")
        }
    }
}
