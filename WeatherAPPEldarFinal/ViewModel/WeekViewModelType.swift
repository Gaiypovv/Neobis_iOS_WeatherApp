//
//  WeekViewModel.swift
//  WeatherAPPEldarFinal
//
//  Created by Eldar Gaiypov on 27/5/23.
//

import Foundation

protocol WeekViewModelType {
    var updateWeek: ((weekWelcome) -> Void)? { get set }
    
    func fetchWeekWeatherData(for cityName: String)
}

class WeekViewModel: WeekViewModelType {
    private var weekWeatherService: WeatherService
    private(set) var weekWeatherData: weekWelcome? {
        didSet {
            bindWeekWeatherViewModelToController?()
        }
    }
    
    var bindWeekWeatherViewModelToController: (() -> Void)?
    var updateWeek: ((weekWelcome) -> Void)?
    
    init() {
        self.weekWeatherService = WeatherService()
        fetchWeekWeatherData(for: "London")
    }
    
    func fetchWeekWeatherData(for cityName: String) {
        weekWeatherService.fetchWeekWeather(for: cityName) { [weak self] weekWeatherData in
            self?.weekWeatherData = weekWeatherData
            self?.updateWeek?(weekWeatherData)
        }
    }
}