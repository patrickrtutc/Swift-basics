//
//  HomeViewModel.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//

import SwiftUI

struct HomeViewModel {
    let products: [Product]
    let searchText: String
    let selectedCategory: String?
    
    var filteredProducts: [Product] {
        var filtered = products
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        return filtered
    }
}
