//
//  MapsSwiftUIApp.swift
//  MapsSwiftUI
//
//  Created by Patrick Tung on 3/6/25.
//

import SwiftUI

@main
struct MapsSwiftUIApp: App {
    let viewModel = MapViewModel() // Instantiate ViewModel at entry point
        
        var body: some Scene {
            WindowGroup {
                MapView(viewModel: viewModel) // Inject into view
            }
        }
}
