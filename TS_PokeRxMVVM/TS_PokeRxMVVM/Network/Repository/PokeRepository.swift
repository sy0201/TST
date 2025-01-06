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
            .map { response -> [Result] in
                // 성공적으로 데이터를 받아왔다면 해당 데이터를 파싱
                do {
                    let pokeResult = try JSONDecoder().decode(PokeResultModel.self, from: response.data)
                    return pokeResult.results
                } catch {
                    throw NetworkError.invalidData
                }
            }
            .catch { error in
                // 에러가 발생했을 경우 적절한 NetworkError로 변환
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                    case .statusCode(let response):
                        // HTTP 상태 코드가 2xx가 아닐 때 처리
                        throw NetworkError.invalidHTTPStatusCode(statusCode: response.statusCode)
                    case .underlying(_, let response) where response != nil:
                        // Response가 없는 경우
                        throw NetworkError.invalidResponse
                    case .underlying(_, _):
                        // 네트워크 연결이 안 되는 경우
                        throw NetworkError.invalidRequest
                    default:
                        // 그 외의 경우
                        throw NetworkError.invalidData
                    }
                } else {
                    throw NetworkError.invalidData
                }
            }
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
            .map { response -> PokeDetail in
                // 디테일을 받아오는 과정에서 데이터 파싱
                do {
                    let pokeDetail = try JSONDecoder().decode(PokeDetail.self, from: response.data)
                    return pokeDetail
                } catch {
                    throw NetworkError.invalidData
                }
            }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                    case .statusCode(let response):
                        throw NetworkError.invalidHTTPStatusCode(statusCode: response.statusCode)
                    case .underlying(_, let response) where response != nil:
                        throw NetworkError.invalidResponse
                    case .underlying(_, _):
                        throw NetworkError.invalidRequest
                    default:
                        throw NetworkError.invalidData
                    }
                } else {
                    throw NetworkError.invalidData
                }
            }
    }
}
