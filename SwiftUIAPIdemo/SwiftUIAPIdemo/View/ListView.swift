//
//  ListView.swift
//  SwiftUIAPIdemo
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.users.isEmpty {
                    Text("No users found")
                } else {
                    List(viewModel.users) { user in
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
                }
            }
            .navigationTitle("User Data")
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}
