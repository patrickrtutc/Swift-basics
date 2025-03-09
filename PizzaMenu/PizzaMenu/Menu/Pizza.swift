import Foundation

struct Pizza {
    let name: String
    let base: Base
    let topping: [Topping]
    
    func isVegetarian() -> Bool {
        return topping.allSatisfy { $0.isVegan }
    }
    
//    func isGlutenFree() -> Bool {
//        return topping.allSatisfy {}
//    }
}
