//
//  ProtocolDelegateDesignPattern.swift
//  WeSplit
//
//  Created by Patrick Tung on 2/13/25.
//

/*
 Protocol Delegate - This is used to delegate certain responsibilities to another class/struct. Defines a protocol that specifies the methods or properties the delegate should implement
 */
import Foundation

public protocol ProtocolDelegate {
    func didReceiveData(_ data: Data)
}
