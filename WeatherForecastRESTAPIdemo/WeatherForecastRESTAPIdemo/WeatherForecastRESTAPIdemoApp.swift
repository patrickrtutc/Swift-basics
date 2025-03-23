//
//  WeatherForecastRESTAPIdemoApp.swift
//  WeatherForecastRESTAPIdemo
//
//  Created by Patrick Tung on 3/6/25.
//

import SwiftUI

@main
struct WeatherForecastRESTAPIdemoApp: App {
    @StateObject private var appState = AppState()
    
    init() {
        // Configure dependencies
        configureDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SearchableMapView(viewModel: appState.weatherViewModel)
                    .environmentObject(appState)
            }
        }
    }
    
    private func configureDependencies() {
        let container = DIContainer.shared
        
        // Register NetworkClient
        container.registerSingleton(type: APIClientProtocol.self, instance: APIClient())
        
        // Register CacheManager
        container.registerSingleton(type: CacheManager.self, instance: CacheManager.shared)
        
        // Register LocationStorage
        container.registerSingleton(type: LocationStorageProtocol.self, instance: LocationStorage())
        
        // Register WeatherRepository
        container.registerSingleton(type: WeatherRepositoryProtocol.self) {
            WeatherRepository(
                apiClient: container.resolve(APIClientProtocol.self),
                cacheManager: container.resolve(CacheManager.self),
                locationStorage: container.resolve(LocationStorageProtocol.self)
            )
        }
    }
}

/// Global app state
@MainActor // Make the whole class MainActor-isolated
class AppState: ObservableObject {
    @Published var weatherViewModel: WeatherDetailsView.ViewModel
    
    init() {
        // Create view model with injected repository
        let repository = DIContainer.shared.resolve(WeatherRepositoryProtocol.self)
        weatherViewModel = WeatherDetailsView.ViewModel(repository: repository)
    }
}
