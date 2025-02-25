//
//  ContentView.swift
//  APIdemo2
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI



struct ContentView: View {
    @State private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading...")
                case .success(let users):
                    List(users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.username)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                case .error(let message):
                    Text("Error: \(message)")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("User Data")
            .task {
                viewModel = await viewModel.loadUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}
