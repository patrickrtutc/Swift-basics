//: [Previous](@previous)

import Foundation

enum Direction : Int, CaseIterable{
    case north
    case south
    case east = 200
    case west
}

for dir in Direction.allCases {
    print("\(dir.rawValue),\(dir)")
}



// Generics - allows code which works for any data type by

func doSum<T : Numeric>(a: T, b: T) -> T {
    return a + b
}

let result = doSum(a: 10, b: 20)
print(result)


// generic struct
struct Queue<T> {
    var items: [T] = []
    
    mutating func enqueue(_ element: T) {
        items.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard !items.isEmpty else {
            print("out of items")
            return nil }
        return items.removeFirst()
    }
    
    func printQueue() {
        print(items)
    }
}

var q = Queue<Int>()
q.enqueue(1)
q.enqueue(2)
q.enqueue(3)

q.printQueue()

if let item = q.dequeue() {
    print(item)
}
if let item = q.dequeue() {
    print(item)
}
if let item = q.dequeue() {
    print(item)
}

if let item = q.dequeue() {
    print(item)
}

enum Rewards<T> {
    case firstPlace(T)
    case secondPlace(T)
    case thirdPlace(T)
    var rewardValue: T {
        switch self {
        case .firstPlace(let value):
            return value
        case .secondPlace(let value):
            return value
        case .thirdPlace(let value):
            return value
        }
    }
}

let firstPlaceWinner: Rewards<String> = .firstPlace("Gold Medal")
let secondPlaceWinner: Rewards<String> = .secondPlace("Silver Medal")
let thirdPlaceWinner: Rewards<String> = .thirdPlace("Bronze Medal")

print(firstPlaceWinner.rewardValue)
print(secondPlaceWinner.rewardValue)
print(thirdPlaceWinner.rewardValue)

//: [Next](@next)
