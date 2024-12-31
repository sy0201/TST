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
    let frontDefault: String
    let name: String
    let height: Int
    let weight: Int
    let types: [PokeType]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case types
        case sprites
    }
    
    enum SpritesKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        types = try container.decode([PokeType].self, forKey: .types)
        
        // Handle nested sprites
        let spritesContainer = try container.nestedContainer(keyedBy: SpritesKeys.self, forKey: .sprites)
        frontDefault = try spritesContainer.decode(String.self, forKey: .frontDefault)
    }
}

struct PokeType: Decodable {
    let type: PokeTypeName
}

struct PokeTypeName: Decodable {
    let name: String
}
