//
//  PokeViewModel.swift
//  TS_PokeRxMVVM
//
//  Created by t2023-m0019 on 12/31/24.
//

import Foundation
import RxSwift
import RxRelay

final class PokeViewModel {
    private let repository: PokeRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    // Output
    let pokeList: BehaviorRelay<[Result]> = BehaviorRelay(value: []) // pokeList와 같이 뷰에 지속적으로 표시되는 데이터 스트림에 적합하다고 판단하여 BehaviorRelay를 사용
    let pokeDetail: BehaviorRelay<PokeDetail?> = BehaviorRelay(value: nil)
    let error: PublishRelay<Error> = PublishRelay()
    
    init(repository: PokeRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadPokeList(offset: Int, limit: Int) {
        repository.fetchPokeList(offset: offset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] results in
                print("Fetched PokeList: \(results)") // 데이터 확인
                self?.pokeList.accept(results)
            }, onFailure: { [weak self] error in
                print("Error Fetching PokeList: \(error)") // 에러 확인
                self?.error.accept(error)
            })
            .disposed(by: disposeBag)
    }
    
    // 포켓몬 디테일 로드
    func loadPokeDetail(id: Int) {
        repository.fetchPokeDetail(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] pokeDetail in
                self?.pokeDetail.accept(pokeDetail)
            }, onFailure: { [weak self] error in
                self?.error.accept(error)
            })
            .disposed(by: disposeBag)
    }
}
