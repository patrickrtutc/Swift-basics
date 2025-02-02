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

// Swift doesn't support multi-level inheritance. So we use protocols.
class LibraryItem: Borrowable, Searchable {
    fileprivate let id: String  // encapsulated Stored Property
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
}


// abstracted unnecessary details for Author
struct Author {
    let name: String
    let birthYear: Int
    var books: [Book]?
    
    // immutable by default
    mutating func addBook(_ book: Book) {
        if books == nil {
            books = [book]
        } else {
            books?.append(book)
        }
    }
}

// Structs have no inheritance
extension Author: Searchable {
    var searchId: String {
        return name
    }
    
    func findallBooks() -> [Book]? {
        guard let books = books else {
            print("No books available")
            return books
        }

        for book in books {
            print("Book Title: \(book.title)")
        }
        return books
    }
}


var orwell = Author(name: "George Orwell", birthYear: 1903)
var fitzgerald = Author(name: "F. Scott Fitzgerald", birthYear: 1896)

print(LibraryItem.totalItems)

let novel = Book(
    id: "1",
    title: "The Great Gatsby",
    author: fitzgerald,
    pageCount: 180
)
let fictionBook = Book(id: "2", title: "1984", author: orwell, pageCount: 328)

// static properties belong to the class
print(LibraryItem.totalItems)

// Polymorphism - Book class objects is treated as instances of LibraryItem through inheritance.
let library: [LibraryItem] = [
    novel, fictionBook
    ]

library[0].checkOut()
library[1].checkOut()
// force downcast with as!
orwell.addBook(library[1] as! Book)

orwell.findallBooks()





//: [Next](@next)
