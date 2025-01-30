// optionals - gives nullable variables
var optionalName: String?

// Optional Binding - getting a value out of optional variable in a safe manner
if let name = optionalName {
    print(name)
}

@MainActor func greet() {
    guard let name2 = optionalName else {
        print("Name is nil")
        return
    }
    print("Hello, \(name2)!")
}


// nil coelscing

print(optionalName ?? "anonymous")

// Force Unwrapping
//print(optionalName!) // This will crash!!
