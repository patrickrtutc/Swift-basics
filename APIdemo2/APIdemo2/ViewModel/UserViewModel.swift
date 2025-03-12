//
//  UserViewModel.swift
//  APIdemo2
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

enum UserViewState {
    case loading
    case success([User])
    case error(String)
}

struct UserViewModel {
    let state: UserViewState
    
    init(state: UserViewState = .loading) {
        self.state = state
    }
    
    func loadUsers() async -> UserViewModel {
        do {
            let users = try await NetworkManager.fetchUsers()
            return UserViewModel(state: .success(users))
        } catch {
            return UserViewModel(state: .error(error.localizedDescription))
        }
    }
}
