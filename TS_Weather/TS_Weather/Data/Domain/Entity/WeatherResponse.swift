//
//  Weather.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let weather: [Weather]?
    let main: Main?
    let timezone, id: Int
    let name: String
    let dt: Int
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
