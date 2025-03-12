//
//  AdapterPattern.swift
//  DesignPatternsSwift
//
//  Created by Bhushan Abhyankar on 12/02/2025.
//
/*
 AdapterPattern - THis makes two incomptiable interfaces to work with each other. It acts as abridge , tranlsating request from one to desired input for other/
 
 UIKit and 3rd party libray
 */

import Foundation


protocol AnalyticsService{
    func logEvent(name:String, parameters:[String:Any]?)
}

class CustomAppAnalytics:AnalyticsService{
    func logEvent(name: String, parameters: [String : Any]?) {
        print("Logging event in CustomAppAnalytics with: \(name), \(parameters ?? [:])")
    }
}

class FireBaseAnalyticsAdapter:AnalyticsService{
    func logEvent(name: String, parameters: [String : Any]?) {
        print("Logging event in FireBaseAnalyticsAdapter with: \(name), \(parameters ?? [:])")
       // Firebase.logEvent(name: name, parameters: parameters)
    }
    
    
}
