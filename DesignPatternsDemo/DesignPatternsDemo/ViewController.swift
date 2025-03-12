//
//  ViewController.swift
//  DesignPatternsDemo
//
//  Created by Patrick Tung on 2/11/25.
//



import SwiftUI
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        testBuilder()
//        testFacadeDP()
//        NotificationCenter.default
//            .addObserver(
//                self,
//                selector: #selector(handleTheReceivedNotification(_ :)), name: .newMessage, object: nil
//            )
    }
    func testAdapterDP() {
        let adaptor = CustomAnalyticsAdaptor()
        adaptor.trackEvent("Button Tap")
    }
    @objc
    func handleTheReceivedNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo , let message = userInfo["messageKey"] as? String {
            print("Chat messages received \(message)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func testBuilder() {
        let pizzaBuilder = PizzaBuilder()
        pizzaBuilder.addCheese().addPepperoni()
            .build()
        print(pizzaBuilder.pizza.description())
    }
    
    func testFacadeDP() {
        let cart = ShoppingCart()
        cart.checkout(items: ["apple", "banana", "orange"],paymentMethod:"credit card", shippingAddress:"123 Main St", paymentAmount: 100.00)
    }
}
//func testBuilder() {
//    let pizzaBuilder = PizzaBuilder()
//    pizzaBuilder.addCheese().addPepperoni().build()
//    print(pizzaBuilder.pizza.description)
//    
//}

#Preview {
    ViewController()
}
