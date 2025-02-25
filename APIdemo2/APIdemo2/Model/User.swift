//
//  User.swift
//  APIdemo2
//
//  Created by Patrick Tung on 2/24/25.
//

import SwiftUI

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
