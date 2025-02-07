//: [Previous](@previous)

import Foundation
/*
 Create new playground taking any example of your choice, so as to display the use of
 Below in Swift
 1. Dependancy Injection
 2. Dependancy inversion
 3. POP different usages for protocols
 4. Private access specifier usage
 */

/// POP encourages composition over inheritance. It aligns well with Swift’s emphasis on value types. 
protocol Animal {
    var name: String { get }
    func breathe()
}

protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

/// classes and structs can conform to multiple protocols at the same time
struct Duck: Animal, Flyable, Swimmable {
    var name = "Donald"
    
    func breathe() {
        print("The animal is breathing!")
    }
    
    func fly() {
        print("The duck is flying!")
    }

    func swim() {
        print("The duck is swimming!")
    }
}

let donald = Duck()
donald.fly()
donald.swim()

/// With POP, can achieve highly modular code that is easy to maintain and loosely coupled.

/// Dependency Inversion
/// 
protocol Database {
    func connect()
}

class DatabaseController {

    private let database: Database

    // Injecting dependency in the form of protocols
    init(db: Database) {
        self.database = db
    }

    func connectDatabase() {
        database.connect()
    }
}

class NetworkRequest: Database {
    func connect() {
        // Connect to the database
    }
}




protocol NetworkServiceProtocol {
    func fetchData() -> String
}

protocol LoggerProtocol {
    func log(_ message: String)
}

protocol AnalyticsProtocol {
    func trackEvent(_ event: String)
}

class NetworkService: NetworkServiceProtocol {
    func fetchData() -> String {
        return "Fetched data from network"
    }
}

class Logger: LoggerProtocol {
    func log(_ message: String) {
        print("📝 Logger: \(message)")
    }
}

class Analytics: AnalyticsProtocol {
    func trackEvent(_ event: String) {
        print("📊 Analytics: Tracked event - \(event)")
    }
}

/// Constructor Injection
class UserService {
    // Core dependencies
    private let networkService: NetworkServiceProtocol
    private let logger: LoggerProtocol
    
    // Constructor Injection
    init(networkService: NetworkServiceProtocol, logger: LoggerProtocol) {
        self.networkService = networkService
        self.logger = logger
    }
    
    func fetchUserData() {
        let data = networkService.fetchData()
        logger.log("User data fetched: \(data)")
    }
}

/// Property Injection
class ContentViewController {
    // Optional dependency that can be passed in after init
    var analytics: AnalyticsProtocol?
    
    func viewDidAppear() {
        analytics?.trackEvent("Content View Appeared")
        loadContent()
    }
    
    private func loadContent() {
        print("Loading content...")
    }
}

/// Method Injection
class ImageProcessor {
    // Dependencies are passed directly to methods that need them
    func processImage(data: Data, using logger: LoggerProtocol) {
        logger.log("Starting image processing")
        // Process image...
        logger.log("Image processing completed")
    }
    
    func uploadImage(data: Data, using networkService: NetworkServiceProtocol) {
        let result = networkService.fetchData()
        print("Upload result: \(result)")
    }
}

// 1. Constructor Injection
print("\n--- Constructor Injection Demo ---")
let userService = UserService(
    networkService: NetworkService(),
    logger: Logger()
)
userService.fetchUserData()

// 2. Property Injection
print("\n--- Property Injection Demo ---")
let viewController = ContentViewController()
viewController.analytics = Analytics() // Injecting the dependency
viewController.viewDidAppear()

// 3. Method Injection
print("\n--- Method Injection Demo ---")
let imageProcessor = ImageProcessor()
let imageData = "Sample Image".data(using: .utf8)!

imageProcessor.processImage(
    data: imageData,
    using: Logger()
)

imageProcessor.uploadImage(
    data: imageData,
    using: NetworkService()
)

//: [Next](@next)
