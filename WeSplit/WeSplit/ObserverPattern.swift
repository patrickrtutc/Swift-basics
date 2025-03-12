//
//  ObserverPattern.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 12/02/2025.
//

/*
 ObserverPattern- This is also called as Publisher/ subscriber pattern
 
 This way of communicating between objects without tight coupling them together is called as PubSub pattern
 
 Tthis pattern allows for an object, also known as publosher  to send notifications to other objects, who are listening to those changes, called as subscribers
 one to many communication
 
 NotificationCenter
 KVO-KVC= Key value Observer, Key value coding
 Custom Implemantaion
 Combine Framework
 
 RXSwift
 RXCocoa
 */

import Foundation

extension Notification.Name {
    static let newMessage = Notification.Name("newMessage")
}

//Publisher
class ChatService{
    
    func sendMessages(message:String){
        print("Sending messages; \(message)")
        
        //boardcast the msgs
        
        NotificationCenter.default.post(name: .newMessage, object: nil, userInfo: ["messageKey":message])
    }
}
