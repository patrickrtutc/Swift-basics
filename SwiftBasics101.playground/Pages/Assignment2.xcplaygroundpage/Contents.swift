//: [Previous](@previous)

import Foundation

//Assignment-2 for today
//Create new playground taking any example of your choice, so as to display the use of
//Below in Swift
//1.Optionals and Optional Binding

var optionalName: String?

if let name = optionalName {
    print(name)
}

// Force Unwrapping
//print(optionalName!) // This will crash!!


//2.Functions and different types for it

@MainActor func greet() {
    guard let name = optionalName else {
        print("Name is nil")
        return
    }
    print("Hello, \(name)!")
}

// nil coalescing operator

func displayData(name: String?) {
    print("The customer name is: \(name ?? "Anonymous").")
}

displayData(name: nil)
displayData(name: "John")



//3.Tuples
let tupleSample = (1,2,2,1)
tupleSample.0

//4.Control Statements in Swift and its uses
//Share your assignment github link once its done on group

enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

if forecast == .sun {
    print("It should be a nice day.")
} else if forecast == .rain {
    print("Pack an umbrella.")
} else if forecast == .wind {
    print("Wear something warm")
} else if forecast == .rain {
    print("School is cancelled.")
} else {
    print("Our forecast generator is broken!")
}

switch forecast {
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella.")
case .wind:
    print("Wear something warm")
case .snow:
    print("School is cancelled.")
case .unknown:
    print("Our forecast generator is broken!")
}

//: [Next](@next)
