//
//  LocationViewModel.swift
//  MapsSwiftUI
//
//  Created by Patrick Tung on 3/6/25.
//
import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region: MKCoordinateRegion = .defaultRegion // Initial default region
    @Published var annotations: [CustomAnnotation] = [] // Points of interest only
    @Published var errorMessage: String? // For error display
    
    private let locationManager = CLLocationManager()
    private var isInitialRegionSet = false // Flag to set region only once
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        setupPredefinedAnnotations() // Add points of interest
    }
    
    // Set up points of interest (no user location here)
    private func setupPredefinedAnnotations() {
        let pointsOfInterest = [
            CustomAnnotation(coordinate: .init(latitude: 37.7749, longitude: -122.4194), title: "San Francisco"),
            CustomAnnotation(coordinate: .init(latitude: 34.0522, longitude: -118.2437), title: "Los Angeles"),
            CustomAnnotation(coordinate: .init(latitude: 40.7128, longitude: -74.0060), title: "New York")
        ]
        annotations.append(contentsOf: pointsOfInterest)
    }
    
    // Request and fetch user location
    func fetchUserLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            errorMessage = "Location access is denied. Please enable it in Settings."
        default:
            break
        }
    }
    
    // Handle authorization changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        fetchUserLocation()
    }
    
    // Update region when location is first received
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if !isInitialRegionSet {
            let coordinate = location.coordinate
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            isInitialRegionSet = true
        }
    }
    
    // Handle location errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to get location: \(error.localizedDescription)"
    }
}

extension MKCoordinateRegion {
    static let defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
}
