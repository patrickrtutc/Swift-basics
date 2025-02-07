//: [Previous](@previous)

import Foundation

/*
 Create new playground taking any example of your choice, so as to display the use of
 Below in Swift
 1. Memory Managment in iOS
 2.Show use of Strong , Weak vs Unowned References
 3.Retain Cycle ,  how to resolve retain cycle
 4. Associated Type
 5. Copy on write (COW)
 */

/// *assoiciatedtype* makes protocols generic
protocol ItemStoring {
    associatedtype DataType

    var items: [DataType] { get set }
    mutating func add(item: DataType)
}

extension ItemStoring {
    mutating func add(item: DataType) {
        items.append(item)
    }
}

/// Swift will figure out that *String* is being used to fill the associated type
struct NameDatabase: ItemStoring {
    var items = [String]()
}

var names = NameDatabase()

/// ARC and Retain Cycle

class Person {
    let name: String
    weak var macbook: MacBook?
    
    init(name: String, macbook: MacBook?) {
        self.name = name
        self.macbook = macbook
        print("\(name) is initialized")
    }
    
    deinit {
        print("\(name) is deinitialized")
    }
}

class MacBook {
    let name: String
    /// weak references need to allow their value to be changed to nil at runtime, they’re always declared as variables, rather than constants, of an optional type.
    weak var owner: Person?
    
    init(name: String, owner: Person?) {
        self.name = name
        self.owner = owner
        print("Macbook named \(name) is initialized")
    }
    
    deinit {
        print("Macbook named \(name) is deinitialized")
    }
}

class Demo {
    var patrick: Person?
    var laptop: MacBook?
    var identity: String?
    
    init(identity: String?) {
        self.identity = identity
    }
    
    func createObjects() {
        patrick = Person(name: "Patrick", macbook: nil)
        laptop = MacBook(name: "MacBook Pro 16", owner: nil)
    }
    
    func assignProperties() {
        patrick?.macbook = laptop
        laptop?.owner = patrick
    }
    
    func deinitializeObjects() {
        patrick = nil
        
        laptop = nil
    }
}

var demo = Demo(identity: "I'm a demo")
demo.createObjects()
demo.assignProperties()
demo.deinitializeObjects()

/// Does Copy on Write apply for class objects?
var demo2 = demo
print()
print(demo2.identity)
print()
//demo = Demo(identity: "I'm another demo")
demo.identity = "I'm another demo"
print(demo.identity)
print(demo2.identity)

//closure capturing


