//
//  DigimonAPISwiftUICombineApp.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/4/25.
//

import SwiftUI

@main
struct DigimonApp: App {
    @StateObject private var viewModel = SearchableDigimonListView.ViewModel(
        apiService: APIServiceManager()
    )
    
    var body: some Scene {
        WindowGroup {
            SearchableDigimonListView().environmentObject(viewModel)
        }
    }
}
