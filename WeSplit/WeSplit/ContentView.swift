//
//  ContentView.swift
//  WeSplit
//
//  Created by Patrick Tung on 2/12/25.
//

import SwiftUI

func testSingleton(){
    let authManager = AuthManager.shared
    
    
    authManager.doLogin(token: "myAuthToken")
    print("After Login")
    print(authManager.isLoggedIn)
    print(authManager.authToken)
    
    print()
    print()
    
    authManager.logout()
    print("After Logout")
    print(authManager.isLoggedIn)
    print(authManager.authToken)
}

func testBuilderDesignPattern(){
    let pizza = PizzaBuilder()
    //            .setDough( "thin")
    //            .setSauce("Tomato garlic")
    //            .addToppings("Mushrooms")
    //            .addToppings( "Onion")
        .build()
    print(pizza.description())
}

func testFactoryDesignPattern(){

   let truck = VehicalFactory.createVehicalObj(type: .truck)
    truck.drive()
    truck.stop()
    
    
    let bike = VehicalFactory.createVehicalObj(type: .bike)
    bike.drive()
    bike.stop()
}

func testFacadeDesignPattern(){
    let cart = ShoppingCart()
    cart.checkout(items: ["iphone","airpods"], shippingAddress: "123, street, NY", paymentMethod: "Apple Pay")
}


func testAdapterDesignPattern(){
    let anlaytics = CustomAppAnalytics()
    anlaytics.logEvent(name: "login", parameters: ["email":"abc@gmai.com", "userId":"123"])
    
    let firebaseAnalytics = FireBaseAnalyticsAdapter()
    firebaseAnalytics.logEvent(name: "login", parameters: ["email":"abc@gmai.com", "userId":"123"])

}

func testClosureDesignPattern(){
    let networkManager = MyNetworkManager()
    if let apiURL = URL(string: "https://jsonplaceholder.typicode.com/todos"){
        networkManager.loadDataFromAPI(url: apiURL, modelType: [Todo].self) { result in
            switch result{
                
            case .success(let recevivedData):
                print(recevivedData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}



enum DesignPatterns: String, CaseIterable, Identifiable {
    case Singleton
    case Factory
    case Builder
    case Adapter
    case Facade
    case Observer
    case Closure

    var id: String { rawValue }
}



private func printExplanation(for pattern: DesignPatterns) -> String {
    switch pattern {
    case .Singleton:
        testSingleton()
        return "Single shared instance and private initializer, shared instance = \(AuthManager.shared)"
    case .Factory:
        testFactoryDesignPattern()
        return "Creating product through factory method"
    case .Builder:
        testBuilderDesignPattern()
        return "Constructing a complex object step-by-step"
    case .Adapter:
        testAdapterDesignPattern()
        return "Making two incompatible interfaces work with each other"
    case .Facade:
        testFacadeDesignPattern()
        return "Simplifying complex subsystems with a single interface"
    case .Observer:
        return "Notifying subscribers of state changes"
    case .Closure:
        testClosureDesignPattern()
        return "Passing functions as parameters dynamically"
    }
}

struct ContentView: View {
    @State private var selectedDesignPattern: DesignPatterns = .Singleton

    var body: some View {
        NavigationStack {
            Form {
                Picker("Select a Design Pattern", selection: $selectedDesignPattern) {
                    ForEach(DesignPatterns.allCases) { pattern in
                        Text(pattern.rawValue).font(.headline)
                            .tag(pattern)
                              // Without .tag(pattern), SwiftUI wouldn’t know which option maps to which enum case in the Picker.
                    }
                }
                .pickerStyle(WheelPickerStyle())
                Text(printExplanation(for: selectedDesignPattern))
                    .font(.headline)
                    .padding()
            }
            .navigationTitle("Design Patterns")
        }
    }
}



#Preview {
    ContentView()
}
