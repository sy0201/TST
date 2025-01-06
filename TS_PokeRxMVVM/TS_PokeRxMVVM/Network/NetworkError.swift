//
//  NetworkError.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 1/6/25.
//

import Foundation

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
            return "invalid Request"
        case .invalidURL:
            return "invalud URL"
        }
    }
}
