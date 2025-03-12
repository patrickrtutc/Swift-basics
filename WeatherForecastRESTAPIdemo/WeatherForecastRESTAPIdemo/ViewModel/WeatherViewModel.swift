//
//  WeatherViewModel.swift
//  WeatherForecastRESTAPIdemo
//
//  Created by Patrick Tung on 3/6/25.
//

import Foundation
import OpenMeteoSdk
import SwiftUI
import CoreLocation

// Enum to represent the state of the forecast data
enum ForecastState {
    case loading
    case success([WeatherApiResponse])
    case error(String)
}

extension WeatherDetailsView {
    
    @Observable @MainActor
    class ViewModel {
        var state: ForecastState = .loading
        var longitude: Double?
        var latitude: Double?
//        var location: CLLocation? {
//            CLLocation(
//                latitude: latitude ?? 33.884,
//                longitude: longitude ?? -84.5144
//            )
//        }
//        let geocoder = CLGeocoder()
        
        func fetchForecast() async {
            guard let url = URL(string: APIEndpoints().getURLdaily(latitude: latitude ?? 33.884, longitude: longitude ?? -84.5144)) else {
                state = .error("Invalid URL")
                return
            }
            
            do {
                let responses = try await WeatherApiResponse.fetch(url: url)
                // Process first location. Add a for-loop for multiple locations or weather models
                let response = responses[0]
                
                /// Attributes for timezone and location
                let utcOffsetSeconds = response.utcOffsetSeconds
                //            let timezone = response.timezone
                //            let timezoneAbbreviation = response.timezoneAbbreviation
                //            let latitude = response.latitude
                //            let longitude = response.longitude
                
                //                let current = response.current!
                
                
                //                let hourly = response.hourly!
                
                let daily = response.daily!
                
                /// Note: The order of weather variables in the URL query and the `at` indices below need to match!
                let data = WeatherData(
                    daily: .init(
                        time: daily.getDateTime(offset: utcOffsetSeconds),
                        weatherCode: daily.variables(at: 0)!.values,
                        temperature2mMax: daily.variables(at: 1)!.values,
                        temperature2mMin: daily.variables(at: 2)!.values
                    )
                )
                
                /// Timezone `.gmt` is deliberately used.
                /// By adding `utcOffsetSeconds` before, local-time is inferred
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = .gmt
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                
                
                
                for (i, date) in data.daily.time.enumerated() {
                    print(dateFormatter.string(from: date))
                    print(data.daily.weatherCode[i])
                    print(data.daily.temperature2mMax[i])
                    print(data.daily.temperature2mMin[i])
                }
                
//                geocoder.reverseGeocodeLocation(location) { placemarks, error in
//                    // Handle the result here
//                }
                
                state = .success(responses)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
        
        func setLocation(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
            Task {
                await fetchForecast()
            }
        }
        
        
        
        
        func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "YY-MM-dd HH:mm zzz"
            return formatter.string(from: date)
        }
        
        func weatherIcon(for code: Float) -> String {
            switch Int(code) {
            case 0: return "sun.max"
            case 1...3: return "cloud.sun"
            case 45, 48: return "cloud.fog"
            case 51...67: return "cloud.rain"
            case 71...77: return "snow"
            case 80...82: return "cloud.heavyrain"
            case 95: return "cloud.bolt"
            default: return "cloud"
            }
        }
        
        func weatherDescription(for code: Float) -> String {
            switch Int(code) {
            case 0: return "Clear"
            case 1...3: return "Partly Cloudy"
            case 45, 48: return "Fog"
            case 51...55: return "Drizzle"
            case 61...65: return "Rain"
            case 71...75: return "Snow"
            case 80...82: return "Showers"
            case 95: return "Thunderstorm"
            default: return "Unknown"
            }
        }
    }
}
