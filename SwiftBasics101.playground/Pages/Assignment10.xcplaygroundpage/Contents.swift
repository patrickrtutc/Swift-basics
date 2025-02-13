//: [Previous](@previous)

import Foundation

/*
 1. AsyncAwait
 2.TaskGroups
 3.Actor
 4.RaceCondition and ways to solve it- serailQueue, NSLock, Semaphore,
 5. DispatchBarier

 DesignPattern- Create new project and show use of the design pattern- Singleton
 */


// Async and Await simplifies asynchronous code with a sequential-looking syntax. It is a Swift native solution that replaces GCD (DispatchQueue). As developers we should always use Swift native Structured Concurrency over GCD
func fetchData() async -> String {
    try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network delay
    return "Data fetched"
}

Task {
    let data = await fetchData()
    print(data) // "Data fetched after 1 second"
}



// Task Group only returns when all of its child tasks finish executing.

func calculateSquareSum() async -> Int {
    await withTaskGroup(of: Int.self) { group in
        let numbers = [1, 2, 3, 4, 5]
        
        for number in numbers {
            group.addTask { number * number }
        }
        
        var sum = 0
        for await result in group {
            sum += result
        }
        return sum // 1+4+9+16+25 = 55
    }
}

Task {
    let sum = await calculateSquareSum()
    print("Sum of squares: \(sum)")
}


// Race Condition - 2 or more threads access a resource at the same time
var unsafeCounter = 0
let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)

for _ in 0..<10000 {
    concurrentQueue.async {
        // both threads can write +1
        // counter shows 1 instead of 2
        unsafeCounter += 1
    }
}
print("unsafeCounter:\(unsafeCounter)")

// The issue is solved when we switch to Swift's native Structured Concurrency

Task {
    var unsafeCounter = 0
    for _ in 0..<10000 {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { unsafeCounter += 1 }
        }
    }
    print("TaskCounter:\(unsafeCounter)")
}

// Final count might be <10000

// I can put the task inside a serial queue
let serialQueue = DispatchQueue(label: "serial")
var safeCounter1 = 0

for _ in 0..<10000 {
    serialQueue.async {
        safeCounter1 += 1
    }
}

print("SerialQueueCounter:\(safeCounter1)")

// Use lock
//var safeCounter2 = 0
//let lock = NSLock()
//
//for _ in 0..<10000 {
//    concurrentQueue.async {
//        lock.lock()
//        safeCounter2 += 1
//        lock.unlock()
//    }
//}
//print("NSLockCounter:\(safeCounter2)")

// Use Semaphore

// Actor isolation
// Actors are designed to work with Swift's modern async/await system

actor Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
}

let counter = Counter()

Task {
    for _ in 0..<10000 {
        await counter.increment()
    }
    print("ActorCounter:\(await counter.count)")
}




// Dispatch Barrier enables exclusive access in concurrent queues
let barrierQueue = DispatchQueue(label: "barrier", attributes: .concurrent)
var sharedData = [String]()

// Concurrent reads
barrierQueue.async { print(sharedData) }

// Exclusive write
barrierQueue.async(flags: .barrier) {
    sharedData.append("New Item")
}
print(sharedData)

struct Counter12 {
    var value: Int = 0
    
    mutating func increment() {
        value += 1
    }
    
    var nextValue: Int {
        increment() // ❌ Error: Cannot call mutating function inside a computed property
        return value
    }
}
//: [Next](@next)


