//: [Previous](@previous)

import Foundation

//Create new playground taking any example of your choice, so as to display the use of
//Below in Swift
//0. Usage of Different data types in swift (Int, String, Bool, Double, float, char)
var numberOfStudents: Int = 100
var name: String = "Swift"
var multiLineString: String = """
The best laid schemes
O’ mice and men
Gang aft agley
"""
var isStudent: Bool = true
var average: Double = 8.5
var letter: Character = "A"
var average2: Float = 9.0
//1.Constants
let pi: Double = 3.1415926
//pi = 3.88

//2.Variables
var age: Int = 21
age += 1

//3.Array, Set, Dictionary and various operations on it

// Array - ordered collection of data

// Set - unique, unordered collection of data

// Dictionary - unique, unordered collection of key-value pairs

var numbers = [Int]()
for i in 1..<10 {
   numbers.append(i)
   numbers.append(i)
}
numbers.append(Int.random(in: 1...384))

var uniqueNumbers = Array(Set(numbers))
var arrayCopy = uniqueNumbers
arrayCopy.count

var sortedNumbers = uniqueNumbers.sorted()

sortedNumbers.remove(at: 3)
sortedNumbers
uniqueNumbers.removeAll()


var mixArray = [Any]()
mixArray.append(1)
mixArray.append("Hello")
mixArray.append(true)

// Set uses insert. Array uses append.
var studentIDs = Set<Int>()
studentIDs.insert(13293)
studentIDs.remove(13293)


//let mixDictionary: [Any: Any] = ["name": "Swift", "age": 21]
var mixDictionary: [AnyHashable: Any] = [false: 9.01, "age": 21]

mixDictionary.remove(at: mixDictionary.startIndex)
mixDictionary.removeValue(forKey: "age")


var additionalDictionary: [AnyHashable: Any] = Dictionary(uniqueKeysWithValues: zip(arrayCopy, sortedNumbers))

//let mergedDictionary = mixDictionary.merging(additionalDictionary) { (_, new) in new }

