//: [Previous](@previous)

import Foundation

/*
1.Closures and its types
2.Enums and its types
3.Generics and different uses
 */


func greetUser() {
    print("Hi there!")
}

greetUser()
var greetCopy : () -> Void = greetUser
greetCopy()

// Non-Escaping Closure
// in keyword marks the start of closure body
let simpleClosure = { (name: String) -> String in return "Hello, \(name)!"}
// parameter name is lost for closures
print(simpleClosure("John"))


let team = ["Alice", "Bob", "Charlie","Tiffany","Tasha"]
print(team.sorted())
// use closure to pass in a custom sorting function
let sortedTeam = team.sorted(by: {(name1: String, name2: String) -> Bool in
    return name1 > name2})

print(sortedTeam)

// trailing closure shorthand syntax for the same closure
//let sortedTeamShorthand = team.sorted { $0 > $1 }
//
//print(sortedTeamShorthand)

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)



// Auto Closure

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"


let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"


print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"



// Escaping Closure

// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []

@MainActor func collectCustomerProviders(
    _ customerProvider: @autoclosure @escaping () -> String
) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))


print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"

// Raw Values
enum PowerUpType: String {
    case shield = "Shield"
    case speedBoost = "Speed Boost"
    case healthPack = "Health Pack"
}

// Associated Values
enum GameEvent {
    case playerDied(reason: String)
// each case in the enum can have different data type
    case scoreChanged(oldScore: Int, newScore: Int)
    case powerUpCollected(type: PowerUpType, duration: Int)
    
    // Computed Property
    var description: String {
        switch self {
        case .playerDied(let reason):
            return "Game Over: \(reason)"
        case .scoreChanged(let old, let new):
            return "Score changed from \(old) to \(new)"
        case .powerUpCollected(let type, let duration):
            return "Collected \(type.rawValue) lasting \(duration) seconds"
        }
    }
}
let temp = GameEvent.scoreChanged(oldScore: 100, newScore: 200)
print(temp.description)

// Generics

struct Stack<T : Numeric> {
    var items: [T] = []
    
    mutating func push(_ element: T) {
        items.append(element)
    }
    
    mutating func pop() -> T? {
        return items.popLast()
    }
    mutating func clear() {
        items.removeAll()
    }
    func peek() -> T? {
        return items.last
    }
    
    func printStack() {
        print(items)
    }
    
}

var stack = Stack<Int>()
stack.push(1)
stack.push(10)
stack.push(100)
stack.printStack()
if let topElement = stack.pop(), let secondPlace = stack.pop() {
    print(topElement, secondPlace)
} else {
    print("The stack is empty")
}
stack.printStack()
stack.clear()
if let topElement = stack.pop() {
    print(topElement)
} else {
    print("The stack is empty")
}
stack.printStack()


//: [Next](@next)
