//
//  PokemonAlamofireCocoapodsSecureStorageApp.swift
//  PokemonAlamofireCocoapodsSecureStorage
//
//  Created by Patrick Tung on 3/19/25.
//

import SwiftUI

@main
struct PokemonAlamofireCocoapodsSecureStorageApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
