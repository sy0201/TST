//
//  NetworkService.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func networkRequest<T: Decodable>(url: String,
                                      method: HTTPMethod,
                                      parameters: [String: Any]?,
                                      completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func networkRequest<T: Decodable>(url: String,
                                      method: HTTPMethod = .get,
                                      parameters: [String : Any]?,
                                      completion: @escaping (Result<T, any Error>) -> Void) {
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
                completion(.failure(error))
            }
        }
    }
}
