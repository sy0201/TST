//
//  NetworkingManager.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    private init() {}
    
    func fetchWeatherData(for lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let url = currentWeatherURL(lat: lat, lon: lon) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 1001, userInfo: nil)))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(WeatherResponse.self, from: data)
                completion(.success(decodedData))
                
            } catch {
                completion(.failure(error))
                print("Decoding error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // 위도, 경도 받아오는 함수
    private func currentWeatherURL(lat: Double, lon: Double, lang: String = "kr") -> URL? {
        guard let apiKey = Bundle.main.apiKey else {
            print("API 키를 로드하지 못했습니다.")
            return nil
        }
        var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: lang)
        ]
        return urlComponents?.url
    }
    
    func fetchForecastData(for lat: Double, lon: Double, completion: @escaping (Result<ForecastWeatherResponse, Error>) -> Void) {
        guard let url = forecastWeatherURL(lat: lat, lon: lon) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 1001, userInfo: nil)))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ForecastWeatherResponse.self, from: data)
                completion(.success(decodedData))
                
            } catch {
                completion(.failure(error))
                print("Decoding error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // 5일간 예보 받아오는 함수
    private func forecastWeatherURL(lat: Double, lon: Double, lang: String = "kr") -> URL? {
        guard let apiKey = Bundle.main.apiKey else {
            print("API 키를 로드하지 못했습니다.")
            return nil
        }
        
        var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast")
        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: lang)
        ]
        return urlComponents?.url
    }
}
