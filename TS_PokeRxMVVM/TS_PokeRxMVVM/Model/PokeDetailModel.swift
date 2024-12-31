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
    var id: Int
    let types: [PokeType]
    let url: String
    let name: String
    let height: Int
    let weight: Int
}

struct PokeType: Decodable {
    let type: PokeTypeName
}

struct PokeTypeName: Decodable {
    let name: String
}
