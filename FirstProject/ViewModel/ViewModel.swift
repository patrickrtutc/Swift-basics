//
//  BaseViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/17/25.
//

import UIKit

class ViewModel {
    
    func invalidEmail(_ email: String) -> String? {
        let emailRegex = """
        ^(?:(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*)|(?:"(?:\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f]|[^\\\\"])*"))@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$
        """
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email) ? nil : "Invalid Email Address"
    }
    
    func invalidPassword(_ password: String) -> String? {
        guard password.isEmpty == false else {
            return "Password cannot be empty"
        }
        guard password.count >= 8 else {
            return "Password must be at least 8 characters long"
        }
        guard password.rangeOfCharacter(from: .whitespacesAndNewlines) == nil else {
            return "Password must not contain whitespace"
        }
        guard password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
            return "Password must contain uppercase letter"
        }
        
        guard password.contains(where: { $0.isNumber }) else {
            return "Password must contain a number"
        }
        guard password.rangeOfCharacter(from: .lowercaseLetters) != nil else {
            return "Password must contain lowercase letter"
        }
        guard password.rangeOfCharacter(from: .punctuationCharacters) != nil else {
            return "Password must contain punctuation"
        }
        return nil
    }
    
}
