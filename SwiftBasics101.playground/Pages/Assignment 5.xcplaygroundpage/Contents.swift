//: [Previous](@previous)

import Foundation

/*
 Create new playground taking any example of your choice, so as to display the use of
 Below in Swift
 1. Higher Order Function
 2.Error Handling , Do try catch ,  try , try!, throw , throws
 3.Initializers
 */

let numbers = [1,2,3,4,5,6,7,8,9]

//print(numbers.reduce(0, %))

enum CalculationError: Error {
    case divisionByZero
    case emptyArray
    case overflow
}

func calculateModuloReduction(_ numbers: [Int]) throws -> Int {
    // Check for empty array
    guard !numbers.isEmpty else {
        throw CalculationError.emptyArray
    }
    do {
        return try numbers.reduce(0) { accumulated, current in
            // Check for division by zero
            guard current != 0 else {
                throw CalculationError.divisionByZero
            }
            
            // Check for potential overflow
            guard accumulated >= 0 && current >= 0 else {
                throw CalculationError.overflow
            }
            
//            print("\(accumulated) , \(current)")
            return accumulated % current
        }
    } catch CalculationError.divisionByZero {
        throw CalculationError.divisionByZero
    } catch {
        throw CalculationError.overflow
    }
}

do {
    let result = try calculateModuloReduction(numbers.filter { $0 != 0 })
    print(result)
} catch {
    print(error)
}

let descendingNumbers = numbers.sorted(by: >)
print(descendingNumbers)

// shorthand parameter name for closure
print(numbers.map {String($0)})

print(numbers.filter {$0.isMultiple(of: 2)})

let mixArray = [[1,2,3,4,5],[6,7,8,9,10]]
// receive a single level collection
print(mixArray.flatMap { $0 })

let mixedArray2: [Int?] = [1,2,nil,3,4,nil]
// remove nils
print(mixedArray2.compactMap { $0 })






class Vehicle {
    var brand: String
    var model: String
    var year: Int
    
    // Designated Initializer - the primary one
    init(brand: String, model: String, year: Int) {
        self.brand = brand
        self.model = model
        self.year = year
    }
    
    // Convenience initializer - calls another initializer
    convenience init(brand: String, model: String) {
        self.init(brand: brand, model: model, year: 2024)
    }
    
    // Failable initializer - returns nil if invalid
    init?(modelNumber: String) {
        guard modelNumber.count >= 3 else { return nil }
        self.brand = "Unknown"
        self.model = modelNumber
        self.year = 2024
    }
    
    // Required Initializer - must be implemented by subclasses
    required init(copying vehicle: Vehicle) {
        self.brand = vehicle.brand
        self.model = vehicle.model
        self.year = vehicle.year
    }
}

let car = Vehicle(brand: "Toyota", model: "Camry")
let car2 = Vehicle(modelNumber: "9")
if let car3 = Vehicle(modelNumber: "123") {
    print(car3.year)
} else {
    print("Invalid model number")
}

class Motorcycle: Vehicle {
    var engineSize: Int
    
    init(brand: String, model: String, year: Int, engineSize: Int) {
        self.engineSize = engineSize
        super.init(brand: brand, model: model, year: year)
    }
    
    required init(copying vehicle: Vehicle) {
        if let motorcycle = vehicle as? Motorcycle {
            self.engineSize = motorcycle.engineSize
        } else {
            self.engineSize = 0  // Default value
        }
        super.init(copying: vehicle)
    }
}

let motorcycle = Motorcycle(brand: "Honda", model: "CBR", year: 2023, engineSize: 600)
let copiedMotorcycle = Motorcycle(copying: motorcycle)
//: [Next](@next)
