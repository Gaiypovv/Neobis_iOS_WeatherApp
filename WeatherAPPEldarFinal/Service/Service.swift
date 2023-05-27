//
//  Service.swift
//  WeatherAPPEldarFinal
//
//  Created by Eldar Gaiypov on 27/5/23.
//

import Foundation

class WeatherService {
    let apiKey = "0abe47131ab221a9c88d30dfdc258602"
    
    func fetchWeather(for cityName: String, completion: @escaping (Welcome) -> ()) {
        guard let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather") else {
            return
        }
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = components?.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Data Task Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(Welcome.self, from: data)
                completion(weather)
            } catch {
                print("Failed to convert: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchWeekWeather(for cityName: String, completion: @escaping (weekWelcome) -> ()) {
        guard let baseWeekUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast") else {
            return
        }
        
        var components = URLComponents(url: baseWeekUrl, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = components?.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Data Task Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(weekWelcome.self, from: data)
                completion(weather)
            } catch {
                print("Failed to convert week: \(error.localizedDescription)")
            }
        }.resume()
    }
}
