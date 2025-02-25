//
//  LoginRequest.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/20/25.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}
