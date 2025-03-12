//
//  ProductService.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//

import SwiftUI

protocol ProductService {
    func getProducts() -> [Product]
}

// Mock implementation with hardcoded data
struct MockProductService: ProductService {
    func getProducts() -> [Product] {
        [
            Product(name: "Luxury Swedian Chair", price: 1299, image: "chair_1", category: "Chair"),
            Product(name: "Fritwood Chair", price: 999, image: "chair_2", category: "Chair"),
            Product(name: "Modern Sofa", price: 1999, image: "chair_4", category: "Sofa")
        ]
    }
}
