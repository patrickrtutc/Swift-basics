//
//  CustomAnnotation.swift
//  MapsSwiftUI
//
//  Created by Patrick Tung on 3/6/25.
//

import Foundation
import MapKit

/// Represents a map annotation with a type for customization.
struct CustomAnnotation: Identifiable {
    let id = UUID() // Unique identifier required for annotationItems
    let coordinate: CLLocationCoordinate2D
    let title: String
}

/// Enum to differentiate annotation types.
enum AnnotationType {
    case user
    case pointOfInterest
}
