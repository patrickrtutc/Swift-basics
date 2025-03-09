//
//  ContentView.swift
//  TabBarProjectSwiftUI
//
//  Created by Patrick Tung on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none).tabItem {
                Label("Prospects", systemImage: "person.3")
            }
            
            ProspectsView(filter: .contacted).tabItem {
                Label("Contacted", systemImage: "checkmark.circle")
            }
            
            ProspectsView(filter: .uncontacted).tabItem {
                Label("Uncontacted", systemImage: "questionmark.diamond")
            }
            
            MeView().tabItem {
                Label("Prospects", systemImage: "person.crop.square")
            }
        }
    }
}

#Preview {
    ContentView()
}
