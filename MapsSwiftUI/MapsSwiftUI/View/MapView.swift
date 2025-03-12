//
//  CurrentLocationMapView.swift
//  MapsSwiftUI
//
//  Created by Patrick Tung on 3/6/25.
//

import Foundation
import MapKit
import SwiftUI

/// Displays a map with custom pins for the user's location and points of interest.
struct MapView: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        ZStack {
            // Map with user location and annotations
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.annotations) { annotation in
                MapMarker(coordinate: annotation.coordinate, tint: .red)
            }
            .edgesIgnoringSafeArea(.all) // Optional: full-screen map
            
            // Display error message if present
            if let error = viewModel.errorMessage {
                VStack {
                    Spacer()
                    Text(error)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            viewModel.fetchUserLocation() // Start fetching location when view appears
        }
    }
}
