//
//  ProductDetailView.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @Binding var cart: Cart
    @State private var quantity: Int = 1
    
    var body: some View {
        VStack(spacing: 20) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            Text(product.name)
                .font(.title2)
                .multilineTextAlignment(.center)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.title3)
                .foregroundColor(.brown)
            Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                .padding(.horizontal)
            Button("Add to Cart") {
                // Add the product multiple times based on quantity
                var updatedCart = cart
                for _ in 0..<quantity {
                    updatedCart = updatedCart.addingProduct(product)
                }
                cart = updatedCart
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.brown)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            Spacer()
        }
        .padding()
        .navigationTitle(product.name)
    }
}
