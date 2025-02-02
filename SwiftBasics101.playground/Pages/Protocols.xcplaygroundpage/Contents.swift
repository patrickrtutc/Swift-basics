//: [Previous](@previous)

import Foundation

// Protocols - a contract for structs implementing it. Contains no details. No instantiation.

// extension - adding optional functions
let num = 5

extension Int {
    func square() -> Int {
        return self * self
    }
}

print(num.square())

//: [Next](@next)
