//: [Previous](@previous)

import Foundation

/*
 Create new playground taking any example of your choice, so as to display the use of
 Below in Swift
 1. GCD- Main Queue
 2.Custom Queues(Serial and Concurrent Queue)
 3.Global Queues
 4.Sync vs Async Behavior
 5.OperatonQueue
 6.DispatchGroups
 */

// Use main queue for UI updates
let mainQueue = DispatchQueue.main
mainQueue.async {
     print("Updated on main queue")
}

// Custom Queues
let serialQueue = DispatchQueue(label: "com.example.serial") // Serial by default
let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent) // Don't do this unless you are locking with barriers

serialQueue.async { print("Task 1") }
serialQueue.async { print("Task 2") }
concurrentQueue.async { print("Task 1") }
concurrentQueue.async { print("Task 2") }

//DispatchQueue.main
//DispatchQueue.global(qos: .userInitiated)
//DispatchQueue.global(qos: .userInteractive)
//DispatchQueue.global(qos: .background)
//DispatchQueue.global(qos: .default)
//DispatchQueue.global(qos: .utility)
//DispatchQueue.global(qos: .unspecified)


// Global Queues
DispatchQueue.global(qos: .background).async {
    // do your job here

    DispatchQueue.main.async {
        // update ui here
    }
}

// Sync vs Async
let q = DispatchQueue.global()

let text = q.sync {
    return "this will block"
}
print(text)

q.async {
    print("this will return instantly")
}

mainQueue.asyncAfter(deadline: .now() + .seconds(2)) {
    //this code will be executed only after 2 seconds have been passed
}

// Dispatch queue simply allows you to perform iterations concurrently
DispatchQueue.concurrentPerform(iterations: 5) { (i) in
    print(i)
}


// OperationQueue
let operationQueue = OperationQueue()
operationQueue.addOperation {
 print(Thread.current)
}

let operation1 = BlockOperation()
operationQueue.addOperation { [unowned operation1] in
    guard !operation1.isCancelled else {
        print("Operation 1 Cancelled!")
        return
    }
    sleep((3))
    print("1", Thread.current)
}
let operation2 = BlockOperation()
operation2.addExecutionBlock { [unowned operation2] in
    guard !operation2.isCancelled else {
        print("Operation 2 Cancelled!")
        return
    }
    sleep((6))
    print("2", Thread.current)
}







// 6. DispatchGroups (Track task completion)

// All of your long running background task can be executed concurrently, when everything is ready you’ll receive a notification.
    
func load(delay: UInt32, completion: () -> Void) {
    sleep(delay)
    completion()
}

let group = DispatchGroup()

group.enter()
load(delay: 1) {
    print("1")
    group.leave()
}

group.enter()
load(delay: 2) {
    print("2")
    group.leave()
}

group.enter()
load(delay: 3) {
    print("3")
    group.leave()
}

group.notify(queue: .main) {
    print("done")
}

//: [Next](@next)
