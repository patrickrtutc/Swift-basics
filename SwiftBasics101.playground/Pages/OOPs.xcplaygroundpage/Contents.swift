//: [Previous](@previous)

import Foundation

// Encapsulation - restricting direct access to data
// private, fileprivate, internal, public, open

// Inheritance - reusing properties and methods from another class. Swift doesn't allow multi-level inheritance.

// Polymorphism - multiple implementation for the same signature. Method overloading & Method overriding

// Abstraction - omission of unnecessary details from a class. Achieved in iOS using protocols.

// Class is a blueprint for objects, it has data and methods.

class Human {
    // Stored properties
    fileprivate var name: String
    fileprivate var age: Int
    
    // initializer
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func walk() {
    }
}

class Student : Human {
    // Computed Property
    //    var marks: [Int] {
    //        for i in 0...100 {
    //            marks.append(Integer.random(in: 0...100))
    //        }
    //        return self.marks
    //    }
    
    // Lazy Property - Doesn't load until called. Only evaluated once.
    //    lazy var favoriteSubject: String = {
    //        //complex api calls
    //        return "call finished"
    //    }
}



// Struct - a value type with no inheritance. immutable by default. no initializer.

struct Employee {
    // can only be changed with mutating func
    var name: String
    var department: String
    var subject: Subject?
    
    func work() -> String {
        "Working hard"
    }
    mutating func updateDepartment(_ newDepartment: String) {
        self.department = newDepartment
    }
}

// classes are reference types, stored on heap memory. Accessing data requires a lookup on the address table, which is slow.
// structs are value types, stored in stack memory, LIFO.
// reassigning struct objects are pass by value.

let h1 = Human(name: "Howard", age: 18)
var h2 = h1
h2.age = 19

print(h1.age) 
print(h2.age)

struct Subject {
    var name: String
}

var emp1 = Employee(name: "John", department: "Engineering")



//emp1.updateDepartment("Sales")
//print(emp1.work())
//: [Next](@next)

let nums = [1,2,3,4]

for (index, val) in nums.enumerated() {
    if val == 3 {
        print("index: \(index), value: \(val)")
        break;
    }
}

let dictionary: [String: Int] = ["a": 1, "b": 2]

for (key, value) in dictionary {
    print("key: \(key), value: \(value)")
}

var i = 25
// executed at least once
repeat {
    print(i)
    i -= 1
} while i > 0
