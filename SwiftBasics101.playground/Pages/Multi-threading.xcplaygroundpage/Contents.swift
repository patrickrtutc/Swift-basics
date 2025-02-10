//: [Previous](@previous)

import Foundation
import UIKit

// Due to the low level nature of threads, Apple thought of a better way.

// GCD - Grand Central Dispatch

// Animation

// execute any ui related task with delay
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("Doing this task after 2 seconds")
}

//: [Next](@next)
