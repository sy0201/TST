//
//  PokeRepository.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol PokeRepositoryProtocol {
    func fetchPokeList(offset: Int, limit: Int) -> Single<[Result]>
    func fetchPokeDetail(id: Int) -> Single<PokeDetail>
}

final class PokeRepository: PokeRepositoryProtocol {
    private let provider = MoyaProvider<PokeAPI>()
    
    // 포켓몬 리스트 가져오기
    func fetchPokeList(offset: Int, limit: Int) -> Single<[Result]> {
        provider.rx.request(.getPokeList(offset: offset, limit: limit))
            .do(onSuccess: { response in
                print("Response: \(response)")
            }, onError: { error in
                print("Error: \(error)")
            })
            .map(PokeResultModel.self)
            .map { $0.results }
    }
    
    // 포켓몬 디테일 가져오기
    func fetchPokeDetail(id: Int) -> Single<PokeDetail> {
        provider.rx.request(.getPokeDetail(id: id))
            .do(onSuccess: { response in
                if let json = try? JSONSerialization.jsonObject(with: response.data, options: []) {
                    print("Detail JSON: \(json)")
                }
            }, onError: { error in
                print("Detail Error: \(error)")
            })
            .map(PokeDetail.self) // JSON 디코딩
    }
}
