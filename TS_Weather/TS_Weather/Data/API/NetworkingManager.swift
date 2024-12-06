//
//  NetworkingManager.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import Foundation
import Alamofire

final class NetworkingManager {
    static let shared = NetworkingManager()
    private init() {}
    
    func fetchWeatherData(for lat: Double, lon: Double, lang: String = "kr", completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let apiKey = Bundle.main.apiKey
        let params: [String: Any] = ["lat": "44.34",
                                     "lon": "10.99",
                                     "appid": apiKey ?? "",
                                     "units": "metric",
                                     "lang": "kr"]

        let url = "https://api.openweathermap.org/data/2.5/weather"
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate()
        .responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                completion(.success(weatherResponse))
            case .failure(let error):
                completion(.failure(error))
                print("Request failed: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchForecastWeatherData(for lat: Double, lon: Double, lang: String = "kr", completion: @escaping (Result<ForecastWeatherResponse, Error>) -> Void) {
        
        let apiKey = Bundle.main.apiKey
        let params: [String: Any] = ["lat": "44.34",
                                     "lon": "10.99",
                                     "appid": apiKey ?? "",
                                     "units": "metric",
                                     "lang": "kr"]

        let url = "https://api.openweathermap.org/data/2.5/forecast"
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        .validate()
        .responseDecodable(of: ForecastWeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                completion(.success(weatherResponse))
            case .failure(let error):
                completion(.failure(error))
                print("Request failed: \(error.localizedDescription)")
            }
        }
    }
}
