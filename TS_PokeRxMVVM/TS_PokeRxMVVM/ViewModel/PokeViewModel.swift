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
    
    // Outputs
    let pokeList = PublishRelay<[Result]>()
    let pokeDetail = PublishRelay<PokeDetail>()
    
    init(repository: PokeRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadPokeList(offset: Int, limit: Int) {
        repository.fetchPokeList(offset: offset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] list in
                self?.pokeList.accept(list)
            }, onFailure: { error in
                print("Error loading poke list: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func loadPokeDetail(id: Int) {
        repository.fetchPokeDetail(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] detail in
                self?.pokeDetail.accept(detail)
            }, onFailure: { error in
                print("Error loading poke detail: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
