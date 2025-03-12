//
//  UserLocationAnnotation.swift
//  MapsSwiftUI
//
//  Created by Patrick Tung on 3/6/25.
//

import MapKit

// MARK: - Model

/// Represents a map annotation for the user's location.
struct UserLocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
