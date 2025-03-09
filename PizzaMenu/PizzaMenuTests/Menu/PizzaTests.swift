import XCTest
@testable import PizzaMenu

class PizzaTests: XCTestCase {
    // Example bases
    private let thinAndCrispyBase = Base(name: "Thin and Crispy",
                                         isVegan: true,
                                         allergens: ["Gluten"])
    private let pepperoniStuffedCrust = Base(name: "Pepperoni Stuffed Crust",
                                             isVegan: false,
                                             allergens: ["Mustard", "Gluten"])

    // Example toppings
    private let tomatoSauce = Topping(name: "Tomato sauce", isVegan: true, allergens: [])
    private let bbqSauce = Topping(name: "Barbecue sauce", isVegan: true, allergens: ["Mustard"])
    private let mozzarella = Topping(name: "Mozzarella", isVegan: false, allergens: ["Milk"])
    private let mushroom = Topping(name: "Mushrooms", isVegan: true, allergens: [])
    private let pepperoni = Topping(name: "Pepperoni", isVegan: false, allergens: ["Gluten", "Mustard"])

    func testWriteYourTestCodeHere() throws {

    }
}
