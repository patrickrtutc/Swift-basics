//
//  WeatherViewModel.swift
//  MoreCombine
//
//  Created by Patrick Tung on 3/5/25.
//

import Combine
import SwiftUI

enum Unit {
    case celsius
    case fahrenheit
}

class WeatherViewModel: ObservableObject {
    // MARK: - Publishers and Subjects
    private let weatherSubject = CurrentValueSubject<Weather, Never>(Weather(temperatureInKelvin: 293.15)) // 20°C
    let unitSubject = CurrentValueSubject<Unit, Never>(.celsius)
    let unitChangeSubject = PassthroughSubject<Unit, Never>()
    
    // MARK: - Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Published Properties
    var temperatureStringPublisher: AnyPublisher<String, Never> {
        Publishers.CombineLatest(weatherSubject, unitSubject)
            .map { weather, unit in
                let tempInCelsius = weather.temperatureInKelvin - 273.15
                let temp = unit == .celsius ? tempInCelsius : (tempInCelsius * 9/5) + 32
                return String(format: "%.1f°%@", temp, unit == .celsius ? "C" : "F")
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    init() {
        setupSubscriptions()
        simulateWeatherFetch()
    }
    
    // MARK: - Private Methods
    private func setupSubscriptions() {
        unitChangeSubject
            .sink { [weak self] newUnit in
                self?.unitSubject.send(newUnit)
            }
            .store(in: &cancellables)
    }
    
    private func simulateWeatherFetch() {
        Just(Weather(temperatureInKelvin: 298.15)) // 25°C
            .delay(for: 2, scheduler: RunLoop.main) // Simulates network delay
            .sink { [weak self] newWeather in
                self?.weatherSubject.send(newWeather)
            }
            .store(in: &cancellables)
    }
}
