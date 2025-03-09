//
//  ContentView.swift
//  WeatherForecastRESTAPIdemo
//
//  Created by Patrick Tung on 3/6/25.
//

import SwiftUI
import OpenMeteoSdk

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                case .success(let responses):
                    let response = responses.first!
//                    let current = response.current!
                    let utcOffsetSeconds = response.utcOffsetSeconds
                    //                    let hourly = response.hourly!
                    let daily = response.daily!
                    
                    
                    
                    let data = WeatherData(
                        daily: .init(
                            time: daily.getDateTime(offset: utcOffsetSeconds),
                            weatherCode: daily.variables(at: 0)!.values,
                            temperature2mMax: daily.variables(at: 1)!.values,
                            temperature2mMin: daily.variables(at: 2)!.values
                        )
                    )
                    List (data.daily.time.indices, id: \.self){ index in
                            HStack {
                                Text(viewModel.formatDate(data.daily.time[index]))
                                    .frame(width: 100, alignment: .leading)
                                Spacer()
                                Image(
                                    systemName: viewModel.weatherIcon(
                                        for: data.daily.weatherCode[index],
                                        isDay: true
                                    )
                                )
                                Spacer()
                                Text("\(data.daily.temperature2mMin[index], specifier: "%.1f")° - \(data.daily.temperature2mMax[index], specifier: "%.1f")°")
                                                                        .frame(width: 100, alignment: .leading)
                            }
                        }
                    
                case .error(let message):
                    Text("Error: \(message)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("Daily Forecast")
            .task {
                await viewModel.fetchForecast()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ContentView.ViewModel())
}
