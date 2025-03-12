//
//  UserViewModel.swift
//  SwiftUIAPIdemo
//
//  Created by Patrick Tung on 2/24/25.
//

// UserViewModel.swift
import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func fetchUsers() async {
        isLoading = true
        do {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
                throw URLError(.badURL)
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let allUsers = try JSONDecoder().decode([User].self, from: data)
            users = Array(allUsers)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            users = []
        }
        isLoading = false
    }
}
