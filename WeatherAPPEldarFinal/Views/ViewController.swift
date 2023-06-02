//
//  ViewController.swift
//  WeatherAPPEldarFinal
//
//  Created by Eldar Gaiypov on 27/5/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var weatherViewModel: WeatherViewModelType
    var weekWeatherViewModel: WeekViewModelType
    let mainView = WeatherView()
    
    var weatherModel: Welcome? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.updateUI()
            }
        }
    }
    
    var weekWeatherModel: weekWelcome? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.updateWeekUI()
            }
        }
    }
    
    init(vm: WeatherViewModelType, vm2: WeekViewModelType) {
        weatherViewModel = vm
        weekWeatherViewModel = vm2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        weatherViewModel = WeatherViewModel()
        weekWeatherViewModel = WeekViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherViewModel.updateSearch = { [weak self] weather in
            self?.weatherModel = weather
        }
        
        weekWeatherViewModel.updateWeek = { [weak self] weekWeather in
            self?.weekWeatherModel = weekWeather
        }
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    }
    
    @objc func searchTapped() {
        let searchController = SearchController()
        
        searchController.onSearch = { [weak self] cityName in
            self?.weatherViewModel.fetchWeatherData(for: cityName)
            self?.weekWeatherViewModel.fetchWeekWeatherData(for: cityName)
        }
        
        let navController = UINavigationController(rootViewController: searchController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    func updateUI() {
        guard let weatherModel = weatherModel else { return }
        let intTemp = Int(round(weatherModel.main.temp))
        mainView.tempLabel.text = "\(intTemp)°C"
        mainView.cityLabel.text = weatherModel.name
        mainView.countryLabel.text = weatherModel.sys.country
        mainView.windStatusValue.text = "\(Int(weatherModel.wind.speed)) mph"
        mainView.humidityStatusValue.text = "\(weatherModel.main.humidity)%"
        mainView.visibilityStatusValue.text = "\(weatherModel.visibility / 1760) miles"
        mainView.pressureStatusValue.text = "\(weatherModel.main.pressure) mb"
        
        if let weatherCondition = weatherModel.weather.first?.main.lowercased() {
            mainView.mainImage.image = selectImageForWeather(weatherCondition)
        }
    }
    
    func updateWeekUI() {
        guard let weekModel = weekWeatherModel else { return }
        
        let dayOneList = Array(weekModel.list.prefix(8))
        let dayOneMaxTemp = dayOneList.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
        mainView.viewFirst.tempLabel.text = "\(Int(round(dayOneMaxTemp)))°C"
        if let weatherCondition = dayOneList.first?.weather.first {
            mainView.viewFirst.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
        }
        
        if weekModel.list.count >= 16 {
            let daySecondList = Array(weekModel.list[8..<16])
            let daySecondMaxTemp = daySecondList.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.viewSecond.tempLabel.text = "\(Int(round(daySecondMaxTemp)))°C"
            if let weatherCondition = daySecondList.first?.weather.first {
                mainView.viewSecond.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }
        
        if weekModel.list.count >= 24 {
            let dayThreeList = Array(weekModel.list[16..<24])
            let dayThreeMaxTemp = dayThreeList.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.viewThree.tempLabel.text = "\(Int(round(dayThreeMaxTemp)))°C"
            if let weatherCondition = dayThreeList.first?.weather.first {
                mainView.viewThree.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }
        
        if weekModel.list.count >= 32 {
            let dayFourList = Array(weekModel.list[24..<32])
            let dayFourMaxTemp = dayFourList.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.viewFour.tempLabel.text = "\(Int(round(dayFourMaxTemp)))°C"
            if let weatherCondition = dayFourList.first?.weather.first {
                mainView.viewFour.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }
        
        
        
        if weekModel.list.count >= 40 {
            let dayFiveList = Array(weekModel.list[32..<40])
            let dayFiveMaxTemp = dayFiveList.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.viewFive.tempLabel.text = "\(Int(round(dayFiveMaxTemp)))°C"
            if let weatherCondition = dayFiveList.first?.weather.first {
                mainView.viewFive.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }
    }
    
    func selectImageForWeather(_ weatherCondition: String) -> UIImage? {
        enum Types: String {
            case clouds
            case rain
            case clear
            case snow
        }
        switch Types(rawValue: weatherCondition) {
        case .clouds:
            return UIImage(named: "clouds")
        case .rain:
            return UIImage(named: "rain")
        case .clear:
            return UIImage(named: "clear")
        case .snow:
            return UIImage(named: "snow")
        default:
            return UIImage(named: "flash")
        }
    }
//        switch weatherCondition {
//        case "clouds":
//            return UIImage(named: "cloud")
//        case "rain":
//            return UIImage(named: "rain")
//        case "clear":
//            return UIImage(named: "sun")
//        case "snow":
//            return UIImage(named: "snow")
//        default:
//            return UIImage(named: "flash")
//        }
//    }
    
    func getImageForWeatherCondition(_ weatherCondition: weekMainEnum) -> UIImage? {
        switch weatherCondition {
        case .clouds:
            return UIImage(named: "cloud")
        case .clear:
            return UIImage(named: "sun")
        case .rain:
            return UIImage(named: "rain")
        }
    }
}
