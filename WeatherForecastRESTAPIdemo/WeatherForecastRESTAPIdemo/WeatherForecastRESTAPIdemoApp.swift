//
//  WeatherForecastRESTAPIdemoApp.swift
//  WeatherForecastRESTAPIdemo
//
//  Created by Patrick Tung on 3/6/25.
//

import SwiftUI

@main
struct WeatherForecastRESTAPIdemoApp: App {
    var viewModel = WeatherDetailsView.ViewModel()
    
    var body: some Scene {
        WindowGroup {
            //                WeatherDetailsView(viewModel: viewModel)
            //                SearchableMapView()
            NavigationStack {
                SearchableMapView(viewModel: WeatherDetailsView.ViewModel())
            }
        }
    }
}
