// optionals - nullable variables
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


// nil coalescing operator

func displayData(name: String?) {
    print("The customer name is: \(name ?? "Anonymous").")
}

displayData(name: nil)
displayData(name: "John")

// Force Unwrapping
//print(optionalName!) // This will crash!!



func doSquaring(_ x: inout Int) {
    x = x * x
}

var num = 5
doSquaring(&num)
print(num)


// tuples - ordered, fixed size, fixed type
var point = (1, 2, 2, 1)

//point = ("3", "4") // error


let temp = 25.0

if temp >= 25 {
    print("It is hot today")
} else {
    print("It is cold today")
}

func checktemperature(temp: Double) -> String {
    switch temp {
    case -20..<0:
        return "It is cold today"
    case 0..<25:
        return "It is mild today"
    default:
        return "It is hot today"
    }
}

//checktemperature(25.0)
checktemperature(temp: -10)





