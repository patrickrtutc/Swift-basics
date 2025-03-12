//
//  User.swift
//  SwiftUIAPIdemo
//
//  Created by Patrick Tung on 2/24/25.
//

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
