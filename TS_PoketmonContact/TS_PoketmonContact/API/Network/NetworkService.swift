//
//  NetworkService.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidData
    case invalidHTTPStatusCode(statusCode: Int)
    case invalidResponse
    case invalidRequest
    case invalidURL
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "invalid data"
        case .invalidHTTPStatusCode(let statusCode):
            return "invalid HTTP status code \(statusCode)"
        case .invalidResponse:
            return "invalid response"
        case .invalidRequest:
            return "invalid request"
        case .invalidURL:
            return "invalid URL"
        }
    }
}

protocol NetworkServiceProtocol {
    func networkRequest<T: Decodable>(url: String,
                                      method: HTTPMethod,
                                      parameters: [String: Any]?,
                                      completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func networkRequest<T: Decodable>(url: String,
                                      method: HTTPMethod = .get,
                                      parameters: [String : Any]?,
                                      completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        // 네트워크 상태 확인
        guard NetworkMonitor.shared.isConnected else {
            completion(.failure(.invalidRequest)) // 네트워크 연결이 없음을 나타내는 에러 반환
            return
        }
        
        guard let validURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type": "application/json", "Accept": "application/json"])
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                if let statusCode = response.response?.statusCode, !(200...299).contains(statusCode) {
                    // statusCode 200~299 이외 에러인 경우
                    completion(.failure(.invalidHTTPStatusCode(statusCode: statusCode)))
                } else if response.response == nil {
                    // 서버로부터 response가 없는 경우
                    completion(.failure(.invalidResponse))
                } else {
                    completion(.failure(.invalidData)) // 기타 데이터 에러인 경우
                }
            }
        }
    }
}
