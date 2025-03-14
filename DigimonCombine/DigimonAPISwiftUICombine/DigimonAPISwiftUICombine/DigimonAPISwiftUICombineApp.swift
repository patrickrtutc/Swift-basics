//
//  DigimonAPISwiftUICombineApp.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/4/25.
//

import SwiftUI

@main
struct DigimonApp: App {
    // Create a shared repository
    private let repository = DefaultDigimonRepository()
    
    // Create view model with the repository
    @StateObject private var viewModel = SearchableDigimonListView.ViewModel(
        repository: DefaultDigimonRepository()
    )
    
    var body: some Scene {
        WindowGroup {
            SearchableDigimonListView()
                .environmentObject(viewModel)
                .onAppear {
                    // Pre-fetch data when app launches
                    viewModel.fetchDigimons()
                }
        }
    }
}
