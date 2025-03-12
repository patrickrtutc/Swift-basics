//
//  BuilderDP.swift
//  DesignPatternsDemo
//
//  Created by Patrick Tung on 2/12/25.
//

// Builder Design Pattern - a creational design pattern. It allows construction on complex object to be separated in steps. Provides a more customized object creation process.

import Foundation

class Pizza {
    var toppings: [String] = []
    
    func addTopping(_ topping: String) {
        toppings.append(topping)
    }
    
    func description() -> String {
        return "Pizza with toppings: \(toppings)"
    }
}

class PizzaBuilder {
    var pizza: Pizza = Pizza()
    
    func addCheese() -> Self {
        pizza.addTopping("Cheese")
        return self
    }
    
    func addPepperoni() -> Self {
        pizza.addTopping("Pepperoni")
        return self
    }
    
    func addMushrooms() -> Self {
        pizza.addTopping("Mushrooms")
        return self
    }
    
    func build() -> Pizza {
        return pizza
    }
}
