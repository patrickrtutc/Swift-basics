//: [Previous](@previous)

import Foundation

var workItem: DispatchWorkItem?
workItem = DispatchWorkItem {
    for i in 1..<6 {
        guard let item = workItem, !item.isCancelled else {
            print("cancelled")
            break
        }
        sleep(1)
        print(String(i))
    }
}

workItem?.notify(queue: .main) {
    print("done")
}


DispatchQueue.global().asyncAfter(
    deadline: .now() + .seconds(2)
) {
    workItem?.cancel()
}
DispatchQueue.main.async(execute: workItem!)




// Dispatch Barrier
// used to manage Concurrent read write operations on shared resource

class Database {
    private var records = [String]()
    
    func readRecords(taskNumber:Int) -> String {
        if self.records.count <= taskNumber {
            return self.records[taskNumber]
        }
        return ""
    }
    
    func writeRecords(newRecord:String) {
        self.records.append(newRecord)
        print("New record added: \(newRecord)")
    }
}

let db = Database()


for i in 0..<10 {
    db.writeRecords(newRecord: String(i))
}

for i in 0..<10 {
    db.readRecords(taskNumber: i)
}

//: [Next](@next)
