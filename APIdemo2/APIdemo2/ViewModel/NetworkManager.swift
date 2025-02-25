//
//  NetworkManager.swift
//  APIdemo2
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

struct NetworkManager {
    static func fetchUsers() async throws -> [User] {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let allUsers = try JSONDecoder().decode([User].self, from: data)
        
        return Array(allUsers)
    }
}
