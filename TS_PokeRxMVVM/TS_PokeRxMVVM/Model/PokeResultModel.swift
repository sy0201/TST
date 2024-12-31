//
//  PokeResultModel.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import Foundation

struct PokeResultModel: Decodable {
    let results: [Result]
}

struct Result: Decodable, Hashable {
    let name: String
    let url: String
    
    var id: Int {
        // URL을 "/" 기준으로 나눔
        let components = url.split(separator: "/")
        // 마지막 요소를 Int로 변환 (숫자가 아닐 경우 기본값 0 반환)
        return Int(components.last ?? "") ?? 0
    }
}
