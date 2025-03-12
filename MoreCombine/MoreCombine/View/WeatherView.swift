//
//  WeatherView.swift
//  MoreCombine
//
//  Created by Patrick Tung on 3/5/25.
//

import SwiftUI
import Combine

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var temperatureString: String = ""
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current Temperature")
                .font(.headline)
            
            Text(temperatureString)
                .font(.largeTitle)
            
            Button(action: {
                let newUnit = viewModel.unitSubject.value == .celsius ? Unit.fahrenheit : Unit.celsius
                viewModel.unitChangeSubject.send(newUnit)
            }) {
                Text("Switch Unit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            cancellable = viewModel.temperatureStringPublisher
                .receive(on: RunLoop.main) // Ensure UI updates on the main thread
                .sink { value in
                    temperatureString = value // Update @State variable
                }
        }
        .onDisappear {
            cancellable?.cancel() // Clean up subscription when the view disappears
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
