//
//  ForecastWeatherResponse.swift
//  TS_Weather
//
//  Created by siyeon park on 12/4/24.
//

import Foundation

// MARK: - ForecastWeatherResponse

struct ForecastWeatherResponse: Codable {
    let list: [ForecastWeather]
}

// MARK: - ForecastWeather

struct ForecastWeather: Codable {
    let main: Main
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case date = "dt_txt"
    }
}
