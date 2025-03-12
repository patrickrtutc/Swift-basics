////
////  MyLocationManager.swift
////  MapsSwiftUI
////
////  Created by Patrick Tung on 3/6/25.
////
//
//import Foundation
//import CoreLocation // getting user location data
//import _MapKit_SwiftUI
//import SwiftUI
//
//class MyLocationManager: NSObject, ObservableObject {
//    private var locationManager = CLLocationManager()
//    
//    @Published var location: CLLocation?
//    @Published var position: MapCameraPosition?
//    
//    override init() {
//        super.init()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization() // asks for permission
//        locationManager.startUpdatingLocation() // gives location data
//    }
//}
//
//extension MyLocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let latestLocation = locations.last else { return }
//        self.location = latestLocation
////        self.position = MapCameraPosition.region(MKCoordinateRegion)
//    }
//}
