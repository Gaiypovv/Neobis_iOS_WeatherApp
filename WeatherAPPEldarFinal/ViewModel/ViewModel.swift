//
//  ViewModel.swift
//  WeatherAPPEldarFinal
//
//  Created by Eldar Gaiypov on 27/5/23.
//

import Foundation

protocol WeatherViewModelType {
    var didTapSearch: (() -> Void)? { get set }
    var updateSearch: ((Welcome) -> Void)? { get set }
    
    func fetchWeatherData(for cityName: String)
}

class WeatherViewModel: WeatherViewModelType {
    private var weatherService: WeatherService
    private(set) var weatherData: Welcome? {
        didSet {
            bindWeatherViewModelToController?()
        }
    }
    
    var bindWeatherViewModelToController: (() -> Void)?
    var didTapSearch: (() -> Void)?
    var updateSearch: ((Welcome) -> Void)?
    
    init() {
        self.weatherService = WeatherService()
        fetchWeatherData(for: "Bishkek")
    }
    
    func fetchWeatherData(for cityName: String) {
        weatherService.fetchWeather(for: cityName) { [weak self] weatherData in
            self?.weatherData = weatherData
            self?.updateSearch?(weatherData)
        }
    }
}
