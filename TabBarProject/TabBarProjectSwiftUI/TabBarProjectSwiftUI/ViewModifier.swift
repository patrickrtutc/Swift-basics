//
//  ViewModifier.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/3/25.
//

import SwiftUI

extension Color {
    static let neumorphicBackground = Color(red: 0.95, green: 0.95, blue: 0.97) // Light beige
    static let neumorphicShadowLight = Color.white
    static let neumorphicShadowDark = Color.gray.opacity(0.5)
    static let accentColor = Color(red: 0.8, green: 0.5, blue: 0.3) // Soft brown from the image
}

struct NeumorphicEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .neumorphicShadowLight, radius: 5, x: -5, y: -5)
            .shadow(color: .neumorphicShadowDark, radius: 5, x: 5, y: 5)
    }
}
