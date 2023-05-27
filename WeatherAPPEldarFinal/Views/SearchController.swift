//
//  SearchController.swift
//  WeatherAPPEldarFinal
//
//  Created by Eldar Gaiypov on 27/5/23.
//

import Foundation
import UIKit
import SnapKit

class SearchController: UIViewController {
    
    var onSearch: ((String) -> Void)?
    
    var weatherViewModel: WeatherViewModelType = WeatherViewModel()
    
    var weekViewModel: WeekViewModelType = WeekViewModel()
    
    let gradientLayer = CAGradientLayer()
    let searchView = UIView()
    let closeButton = UIButton()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 48/255, green: 162/255, blue: 197/255, alpha: 1.0).cgColor,
            UIColor(red: 0/255, green: 36/255, blue: 47/255, alpha: 1.0).cgColor
        ]
        view.layer.addSublayer(gradientLayer)
        
        setupUI()
        setupConstraints()
        
        textField.delegate = self
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        searchView.backgroundColor = .white
        searchView.layer.cornerRadius = 50
        
        closeButton.setImage(UIImage(named: "Vector"), for: .normal)
        
        textField.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        let placeholder = NSAttributedString(string: "SEARCH LOCATION", attributes: attributes)
        textField.attributedPlaceholder = placeholder
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 20
        textField.returnKeyType = .search
    }
    
    private func setupConstraints() {
        view.addSubview(searchView)
        view.addSubview(closeButton)
        view.addSubview(textField)
        
        searchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY)
            make.top.equalToSuperview().inset(80)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchView.snp.trailing).inset(15)
            make.top.equalTo(searchView.snp.top).inset(15)
            make.size.equalTo(50)
        }
        
        textField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(50)
            make.top.equalTo(closeButton.snp.bottom)
            make.height.equalTo(40)
        }
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if let cityName = textField.text {
            weatherViewModel.fetchWeatherData(for: cityName)
            weekViewModel.fetchWeekWeatherData(for: cityName)
            onSearch?(cityName)
        } else {
            print("No city name found")
        }
         
        closeButtonTapped()
        return true
    }
}
