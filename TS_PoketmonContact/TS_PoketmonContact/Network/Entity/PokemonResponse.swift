//
//  PokemonResponse.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import Foundation

struct PokemonResponse: Decodable {
    let name: String
    let sprites: Sprites
}

struct Sprites: Decodable {
    let frontDefault: String?
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
