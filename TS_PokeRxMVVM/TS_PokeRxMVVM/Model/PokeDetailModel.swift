//
//  PokeDetailModel.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import Foundation

struct PokeDetailModel: Decodable {
    let results: [PokeDetail]
}

struct PokeDetail: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokeType]
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case types
        case sprites
    }
}

// 스프라이트 이미지 URL을 위한 새로운 구조체
struct Sprites: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
struct PokeType: Decodable {
    let type: PokeTypeName
}

struct PokeTypeName: Decodable {
    let name: String
}
