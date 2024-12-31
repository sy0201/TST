//
//  PokeAPI.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import Foundation
import Moya

enum PokeAPI {
    case getPokeList(offset: Int, limit: Int)
    case getPokeDetail(id: Int)
    
}

extension PokeAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://pokeapi.co")!
    }
    
    var path: String {
        switch self {
        case .getPokeList(_, _):
            return "/api/v2/pokemon"
        case .getPokeDetail(let id):
            return "/api/v2/pokemon/\(id)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getPokeList(let offset, let limit):
            let params: [String: Any] = [
                "offset": offset,
                "limit": limit
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getPokeDetail(let id):
            let params: [String: Any] = [
                "id": id
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
