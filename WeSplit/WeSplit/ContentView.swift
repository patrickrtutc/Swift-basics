//
//  ContentView.swift
//  WeSplit
//
//  Created by Patrick Tung on 2/12/25.
//

import SwiftUI

enum DesignPatterns: String, CaseIterable, Identifiable {
    case Singleton
    case Factory
    case Builder
    case Adapter
    case Facade
    case Observer
    case Closure

    var id: String { rawValue }
}

private func printExplanation(for pattern: DesignPatterns) -> String {
    switch pattern {
    case .Singleton:
        return "Single shared instance and private initializer"
    case .Factory:
        return "Creating product through factory method"
    case .Builder:
        return "Constructing a complex object step-by-step"
    case .Adapter:
        return "Making two incompatible interfaces work with each other"
    case .Facade:
        return "Simplifying complex subsystems with a single interface"
    case .Observer:
        return "Notifying subscribers of state changes"
    case .Closure:
        return "Passing functions as parameters dynamically"
    }
}

struct ContentView: View {
    @State private var selectedDesignPattern: DesignPatterns = .Singleton

    var body: some View {
        NavigationStack {
            Form {
                Picker("Select a Design Pattern", selection: $selectedDesignPattern) {
                    ForEach(DesignPatterns.allCases) { pattern in
                        Text(pattern.rawValue).font(.headline)
                            .tag(pattern)
                              // Without .tag(pattern), SwiftUI wouldn’t know which option maps to which enum case in the Picker.
                    }
                }
                .pickerStyle(WheelPickerStyle())
                Text(printExplanation(for: selectedDesignPattern))
                    .font(.headline)
                    .padding()
            }
            .navigationTitle("Design Patterns")
        }
    }
}

#Preview {
    ContentView()
}
