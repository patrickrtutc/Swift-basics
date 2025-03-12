import Foundation

struct Pizza {
    let name: String
    let base: Base
    let topping: [Topping]
    
    func isVegetarian() -> Bool {
        return topping.allSatisfy { $0.isVegan }
    }
    
    func isGlutenFree() -> Bool {
        return topping.allSatisfy{
            $0.allergens.contains("Gluten") == false
        }
    }
    
    func listAllergens() -> [String] {
        var allergens: Set<String> = []
        topping.forEach {
            allergens.formUnion($0.allergens)
        }
        return allergens.sorted()
    }
    
    /*
     Create a function which returns all of a pizza's toppings, ordered by sauce, then cheese, then all other
     toppings (ordered alphabetically)
     */
    func listToppingsByToppingType() -> [Topping] {
        return topping.sorted()
    }
}
