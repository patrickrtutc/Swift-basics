//
//  AmericanAirlinesCodingChallengeApp.swift
//  AmericanAirlinesCodingChallenge
//
//  Created by Patrick Tung on 3/20/25.
//

import SwiftUI

@main
struct AmericanAirlinesCodingChallengeApp: App {
    init() {
        // This is just to make sure the compiler doesn't remove the AppTransportSettings.swift file
        // The actual settings are applied through the Info.plist settings in the project configuration
        _ = 0 // No-op, the comment above is what matters
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
