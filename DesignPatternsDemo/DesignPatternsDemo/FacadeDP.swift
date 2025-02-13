//
//  FacadeDP.swift
//  DesignPatternsDemo
//
//  Created by Patrick Tung on 2/12/25.
//

// Structural DP, provides a simple interface to a complex subsystem

class ShoppingCart {
    private let inventory = InventoryManager()
    private let paymentGateway = PaymentGateway()
    private let shippingManager = ShipmentManager()
    
    func checkout(items: [String], paymentMethod: String, shippingAddress: String,
    paymentAmount: Double) {
        // check inventory
        guard inventory.checkInventory(itemNames: items) else {
            return
        }
        
        guard paymentAmount > 0 else {
            return
        }
        guard !paymentMethod.isEmpty else {
            return
        }
        guard shippingManager.shipOrder(items:items, shippingAddress:shippingAddress) else {
            return
        }
        print("Checkout successful")
        
    }
}
class PaymentGateway {
    func processPayment(amount: Double, paymentMethod: String) {
        
    }
}

class InventoryManager {
    func checkInventory(itemNames: [String]) -> Bool {
        return true
    }
}

class ShipmentManager {
    func shipOrder(items: [String], shippingAddress: String) -> Bool {
        return true
    }
}
