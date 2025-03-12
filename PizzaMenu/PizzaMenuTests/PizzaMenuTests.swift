import XCTest
@testable import PizzaMenu

class PizzaMenuTests: XCTestCase {
    
    private func makeTopping(type: ToppingType, name: String, isVegan: Bool = false, allergens: [String] = []) -> Topping {
        return Topping(type: type, name: name, isVegan: isVegan, allergens: allergens)
    }
    
    func testListToppingsByToppingType() {
        let sauce = Topping(type: .Sauce, name: "Tomato sauce", isVegan: true, allergens: [])
        let cheese = Topping(type: .Other, name: "Mozzarella", isVegan: false, allergens: ["Milk"])
        let other = Topping(type: .Other, name: "Mushrooms", isVegan: true, allergens: [])
        
        let base = Base(name: "ThinCrust", isVegan: false , allergens:  ["Wheat"])
        
        let pizza = Pizza(name: "Margherita", base: base, topping: [other, cheese, sauce])
        
        let expected = [sauce, cheese, other]
        let result = pizza.listToppingsByToppingType()
        XCTAssertEqual(result, expected, "Single toppings per category should be ordered: Sauce, Cheese, Other")
    }
    
}
