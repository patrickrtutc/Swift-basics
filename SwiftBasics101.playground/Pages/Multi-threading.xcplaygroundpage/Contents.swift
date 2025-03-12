//: [Previous](@previous)

import Foundation

// Due to the low level nature of threads, Apple thought of a better way.

// GCD - Grand Central Dispatch

// Animation

// execute any ui related task with delay
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("Doing this task after 2 seconds")
}

// serial queue
let myQueue = DispatchQueue(label: "myQueue")

myQueue.async {
    print("Task 1 Started")
    print("Task 1 in progress")
    print("Task 1 Finished")
}

print()

myQueue.async {
    print("Task 1 Started")
    print("Task 1 in progress")
    print("Task 2 Finished")
}

// concurrent Queue - execute tasks simultaneously
let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

// Global queue - system provided concurrent queue with different priority/QoS. Doesn't use the main thread.
/*
 QoS Quality of Service
 1. UserInteractive - used for animations
 2. UserInitiated - pull to refresh, etc.
 3. Default - between userInitiated and Utility
 4. Utility - Long running tasks. Downloads, etc.
 5. Background - not visible. backup, syncing data, etc.
 6. Unspecified - good to have functionality
 */
DispatchQueue.global(qos: .utility).async {
    print("Global Queue Task Started")
    print("Global Queue Task in progress")
    for i in 0...10 {
        print(i)
    }
    print("Global Queue Task Finished")
}


/*
 Operation Queue - There are two APIs that you’ll use when making your app concurrent: GCD, and Operations. These are neither competing technologies nor something that you have to exclusively pick between. In fact, Operations are built on top of GCD! Pause resume cancel start operations in a queue. set dependency among tasks using that queue.
 
 
 */

let taskToBeExecutedConcurrently = BlockOperation {
    print("Task 1 Started")
    print("Task 1 in progress")
    for i in 0...10 {
        print(i)
    }
    print("Task 1 Finished")
}
let task2 = BlockOperation {
    print("Task 2 Started")
    print(Thread.isMainThread)
    print("Task 2 in progress")
    for i in 0...10 {
        print(i)
    }
    print("Task 2 Finished")
}

let task3 = BlockOperation {
    print("Task 3 Started")
    print("Task 3 in progress")
    for i in 0...10 {
        print(i)
    }
    print("Task 3 Finished")
}

let operationQueue = OperationQueue()
operationQueue.addOperations([task2, taskToBeExecutedConcurrently, task3], waitUntilFinished: false)
taskToBeExecutedConcurrently.addDependency(task2)
operationQueue.maxConcurrentOperationCount = 1



// Async Await Swift Concurrency - available from iOS 13, Swift 5.5 in year 2019

//func getAPIResponse() async {
//    print("API callling...")
//    sleep(2)
//}
//Task {
//    await getAPIResponse()
//}

// TaskGroup - execute multiple concurrent tasks and await for the results. Useful for performing multiple independent tasks in parallel.

func gettingDataFromMultipleAPI() async {
    await withTaskGroup(of: String.self) {
        group in
        let apis = ["https://jsonplaceholder.typicode.com/todos/1", "https://jsonplaceholder.typicode.com/todos/2", "https://jsonplaceholder.typicode.com/todos/3",
        "https://jsonplaceholder.typicode.com/todos/4", "https://jsonplaceholder.typicode.com/todos/5"]
        for url in apis {
            group.addTask {
                return "Data from \(url)"
            }
        }
        var result = [String]()
        for await data in group {
            result.append(data)
        }
        result.forEach { print($0) }
    }
}
Task{
    await gettingDataFromMultipleAPI()
}

func easyTaskGroup() async {
    await withTaskGroup(of: String.self) {
        group in
        group.addTask { "Task 1" }
        group.addTask { "Task 2" }
        group.addTask { "Task 3" }
        group.addTask { "Task 4" }
        group.addTask { "Task 5" }
        group.addTask { "Task 6" }
        group.addTask { "Task 7" }
        for await taskResult in group {
            print(taskResult)
        }
    }
}
Task {
    await easyTaskGroup()
}


