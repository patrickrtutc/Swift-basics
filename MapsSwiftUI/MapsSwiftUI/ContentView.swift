////
////  ContentView.swift
////  MapsSwiftUI
////
////  Created by Patrick Tung on 3/6/25.
////
//
//import SwiftUI
//import MapKit // only for UI
//
//struct ContentView: View {
//    
//    @State var staticRegion = MapCameraPosition.region (MKCoordinateRegion(center: CLLocationCoordinate2DMake(51.007222, -0.27), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
//    
//    @StateObject var mylocation = MyLocationManager()
//    var dynamicPosition: Binding<MapCameraPosition>? {
//        didSet {
//            if let position = dynamicPosition {
//                staticRegion = MapCameraPosition.region(MKCoordinateRegion(center: position, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
//            }
//        }
//    }
//    
//    
//    var body: some View {
//        NavigationStack{
//            ZStack {
////                Map(coordinateRegion: $staticRegion)
//                if let position = mylocation.position {
//                    Map(initialPosition: position)
//                }
//            }.ignoresSafeArea()
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
