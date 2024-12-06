//
//  ForecastViewModel.swift
//  TS_Weather
//
//  Created by siyeon park on 12/5/24.
//

import Foundation

final class ForecastViewModel {
    private var forecastData: ForecastWeatherResponse?
    var updateForecastData: (() -> Void)?
    
    func fetchForecast(lat: Double, lon: Double) {
        NetworkingManager.shared.fetchForecastWeatherData(for: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let response):
                self?.forecastData = response
                print("Weather data updated: \(String(describing: self?.forecastData))")

                print("Forecast list: \(String(describing: self?.forecastData?.list))")

                DispatchQueue.main.async {
                    self?.updateForecastData?()
                }
            case .failure(let failure):
                print("FetchForecastError: \(failure.localizedDescription)")
            }
        }
    }
    
    func getForecastList() -> [ForecastWeather] {
        if let forecastList = forecastData?.list {
            return forecastList
        } else {
            return []
        }
    }
}
