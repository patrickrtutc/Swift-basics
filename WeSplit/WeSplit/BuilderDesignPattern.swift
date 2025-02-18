//
//  BuilderDesignPattern.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 12/02/2025.
//
/*
 
 Builder Desing Pattern= Its a creational design pattern
 - It allows the constuction on complex object to be seperated in steps
 - this provides a way to create objexts steps by step, allowing the object creation more customized
 
 */

import Foundation

class Pizza{
    var dough: String = "thick"
    var sauce: String = "tomato"
    var toppings: [String] = []
    
    func description() ->String{
        return "Pizza with base as \(dough), sause is \(sauce) and toppings are \(toppings.joined(separator: ", "))"
    }
    
}

class PizzaBuilder{
    
    private var pizza: Pizza = Pizza()
    
    
    func setDough(_ dough:String) -> PizzaBuilder{
        pizza.dough = dough
        return self
    }
    
    func setSauce(_ sauce:String) -> PizzaBuilder{
        self.pizza.sauce = sauce
        return self
    }
    
    func addToppings(_ topping:String) -> PizzaBuilder{
        pizza.toppings.append(topping)
        return self
    }
    
    func build() -> Pizza{
        return pizza
    }
}


class Car{
    let make:String?
    let model:String?
    let color:String?

    init(make: String?, model: String?, color: String?) {
        self.make = make
        self.model = model
        self.color = color
    }
}

class CarBuilder{
    var car = Car(make: nil, model: nil, color: nil)
    
    var make:String = ""
    var model:String = ""
    var color:String = ""
    
    func setMake(_ make:String) -> CarBuilder{
        self.make = make
        return self
    }
    
    func setModel(_ model:String) -> CarBuilder{
        self.model = model
        return self
    }
    
    func setColor(_ color:String) ->CarBuilder{
        self.color = color
        return self

    }
    
    func build() ->Car{
        return car
    }
}
var myCar = CarBuilder()
    .setColor("blue")
    .setMake("Toyota")
    .setModel("Camry")
    .build()
