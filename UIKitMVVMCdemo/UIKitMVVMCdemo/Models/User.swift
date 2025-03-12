import Foundation

struct User {
    let id: String
    let name: String
    let age: Int
    
    static func mockUsers() -> [User] {
        return [
            User(id: "1", name: "John Doe", age: 28),
            User(id: "2", name: "Jane Smith", age: 32),
            User(id: "3", name: "Mike Johnson", age: 45)
        ]
    }
} 