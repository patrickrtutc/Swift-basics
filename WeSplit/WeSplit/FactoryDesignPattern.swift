//
//  FactoryDesignPattern.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 12/02/2025.
//

/*
 factory design pattern
 
 -its a creational design pattern
 it provides an objection creation in super class, but allows subclass to alter the type of obj that will be created
 
 -Network Client Factory -
 -UI theme Factory-
 ViewController Factory
 */

import Foundation

protocol Vehical{
    var name: String {get}
    func drive()
    func stop()
}

class Truck:Vehical{
    var name: String = "Truck"
    
    func drive() {
        print("Driving a Truck")
    }
    
    func stop() {
        print("Truck is stopped")
    }
}

class Bike:Vehical{
    var name: String = "Bike"
    
    func drive() {
        print("Driving a Bike")
    }
    
    func stop() {
        print("Bike is stopped")
    }
}

enum VehicalType{
    case truck
    case bike
}
class VehicalFactory{
    
    static func createVehicalObj(type:VehicalType) -> Vehical{
        switch type {
        case .truck:
            let truck = Truck()
            return truck
        case .bike:
            let bike = Bike()
            return bike
        }
    }
}
