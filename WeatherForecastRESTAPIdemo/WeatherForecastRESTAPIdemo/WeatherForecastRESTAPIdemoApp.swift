//
//  WeatherForecastRESTAPIdemoApp.swift
//  WeatherForecastRESTAPIdemo
//
//  Created by Patrick Tung on 3/6/25.
//

import SwiftUI

@main
struct WeatherForecastRESTAPIdemoApp: App {
    let viewModel = ContentView.ViewModel()
        
        var body: some Scene {
            WindowGroup {
                ContentView(viewModel: viewModel)
            }
        }
}
