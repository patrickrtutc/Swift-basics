//
//  ObserverDP.swift
//  DesignPatternsDemo
//
//  Created by Patrick Tung on 2/12/25.
//

import Foundation

// NotificationCenter
// Combine Framework

extension Notification.Name {
    static let newMessage = Notification.Name("newMessage")
}

// the publisher
class ChatService {
    func sendMessage(_ message: String) {
        print("Sending messages: \(message)")
        
        // broadcast the message
        NotificationCenter.default.post(name: .newMessage, object: nil, userInfo : ["messageKey": message])
    }
}
