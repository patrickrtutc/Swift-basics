//: [Previous](@previous)

import Foundation

//Assignment-2 for today
//Create new playground taking any example of your choice, so as to display the use of
//Below in Swift
//1.Optionals and Optional Binding

let album = "Thriller"
let albums = ["Thriller", "Back in Black", "Purple Rain"]
//array.firstIndex(of:) returns an optional
if let position = albums.firstIndex(of: album) {
    print("We found \(album) at position \(position)")
} else {
    print("We didn't find \(album)")
}



// Force Unwrapping
//print(optionalName!) // This will crash!!


//2.Functions and different types for it
var optionalName: String?

@MainActor func greet() {
    guard let name = optionalName else {
        print("Name is nil")
        return
    }
    print("Hello, \(name)!")
}

greet()

// nil coalescing operator

func displayData(name: String?) {
    print("The customer name is: \(name ?? "Anonymous").")
}

displayData(name: nil)
displayData(name: "John")

// inout parameters
var count = 10

func increment(_ num: inout Int) {
    num += 5
}

increment(&count)
print(count)

// omit parameter label, default value for a parameter
func square(_ number: Int = 0) -> Int {
    return number * number
}
print(square())


//3.Tuples
let tupleSample = (1,2,2,1)
print(tupleSample.0, tupleSample.1)

//4.Control Statements in Swift and its uses
//Share your assignment github link once its done on group

enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

func checkForecast(_ forecast: Weather) -> String {
    switch forecast {
    case .sun:
        return "It should be a nice day."
    case .rain:
        return "Pack an umbrella."
    case .wind:
        return "Wear something warm"
    case .snow:
        return "School is cancelled."
    case .unknown:
        return "Our forecast generator is broken!"
    }
}

//: [Next](@next)
