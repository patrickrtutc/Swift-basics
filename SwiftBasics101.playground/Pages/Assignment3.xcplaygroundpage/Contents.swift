//: [Previous](@previous)

import Foundation

// Optional Chaining - reading optionals inside optionals
//struct Book {
//    let title: String
//    let author: String?
//}
//
//var book: Book? = nil
//let author = book?.author?.first?.uppercased() ?? "Undefined"
//print(author)



// Classes and OOPs principle, Protocol, Extensions, TypesOfProperties


protocol Borrowable {
    var isAvailable: Bool { get set }
    func checkOut()
    func checkIn()
}

protocol Searchable {
    var searchId: String { get }
}

class LibraryItem: Borrowable, Searchable {
    let id: String  // Stored Property
    var title: String
    var isAvailable: Bool
    
    // Swift requires an explicit type with computed properties
    var searchId: String {
        return "\(id)-\(title)"
    }
    
    // Static Property
    static var totalItems = 0
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
        self.isAvailable = true
        LibraryItem.totalItems += 1
    }
    
    func checkOut() {
        isAvailable = false
    }
    
    func checkIn() {
        isAvailable = true
    }
    func findBooksByAuthor() {
    }
}

struct Author {
    let name: String
    let birthYear: Int
    var books: [Book]?
}


class Book: LibraryItem {
    var author: Author
    var pageCount: Int
    
    init(id: String, title: String, author: Author, pageCount: Int) {
        self.author = author
        self.pageCount = pageCount
        super.init(id: id, title: title)
    }
    
    override func checkOut() {
        super.checkOut()
        print("Book '\(title)' has been checked out.")
    }
    
    override func findBooksByAuthor() {
        guard let books = author.books else {
            print("No books found for \(author.name)")
            return
        }
            
        print(author.name)
        for book in books {
            print("Book Title: \(book.title)")
        }
    }
}

// Polymorphism - Book class objects is treated as instances of LibraryItem through inheritance.
let library: [LibraryItem] = [
    Book(id: "1", title: "The Great Gatsby", author: Author(name: "F. Scott Fitzgerald", birthYear: 1896), pageCount: 180),
    Book(id: "2", title: "1984", author: Author(name: "George Orwell", birthYear: 1903), pageCount: 328)]

library[0].checkOut()
library[1].checkOut()
library[1].findBooksByAuthor()




//: [Next](@next)
