//
//  AdaptorDP.swift
//  DesignPatternsDemo
//
//  Created by Patrick Tung on 2/12/25.
//

import Foundation

protocol AnalyticsAdaptor {
    func trackEvent(_ event: String)
}

class CustomAnalyticsAdaptor: AnalyticsAdaptor {
    func trackEvent(_ event: String) {
        print("Custom Analytics: \(event)")
    }
}

class FirebaseAnalyticsAdaptor: AnalyticsAdaptor {
    func trackEvent(_ event: String) {
        print("Firebase Analytics: \(event)")
    }
}
