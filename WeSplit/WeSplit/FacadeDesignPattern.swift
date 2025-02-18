//
//  FacadeDesignPattern.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 12/02/2025.
//

/*
 FacadeDesignPattern-
 - Structural desgin pattern
 - It provides simplified interface to a complex subsystem
 - This acts as an intermeditory between client and complex subsystem. hiding all compluixity of system and providng only certain useful access points
 
 */

import Foundation

class ShoppingCart{
    //items
    //address
    //paymentMethod
    
    private let inventory = IntentoryManagement()
    private let paymentProccessing = PaymentManagement()
    private let shippingManger = ShipmentManager()
    
    func checkout(items:[String], shippingAddress:String, paymentMethod:String){
       //Check inventory
        guard inventory.checkAvaiablity(items: items) else{
            print("Some items are not in stock")
            return
        }
        
        //Process payment
        guard paymentProccessing.processPayment(paymentMethod: paymentMethod) else{
            print("Payment processing Failed")
            return
        }
        
        //Ship the items
        guard shippingManger.ship(items: items, to: shippingAddress) else{
            print("Shipment failed")
            return
        }
        
        //All good
        print("Order placement is sucessful")
        
    }
}

class IntentoryManagement{
    func checkAvaiablity(items:[String]) -> Bool{
        //thigs are in stock
        return true
    }
}

class PaymentManagement{
    func processPayment(paymentMethod:String) -> Bool{
        //logic for payement processing
        return true
    }
}
class ShipmentManager{
    func ship(items:[String], to address:String) -> Bool{
        //this will manage the shipment to given address
        return true
    }
}

