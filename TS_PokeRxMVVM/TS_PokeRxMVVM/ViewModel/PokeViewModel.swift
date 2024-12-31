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
    
    // Pagination properties
    private var currentOffset = 0
    private let limit = 20
    private var isLoading = false
    private var canLoadMore = true
    
    private var currentItems: [Result] = []
    
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
    
    func loadMorePokemon() {
        guard !isLoading && canLoadMore else { return }
        
        isLoading = true
        repository.fetchPokeList(offset: currentOffset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] list in
                guard let self = self else { return }
                
                // 더 이상 로드할 데이터가 없는 경우
                if list.isEmpty {
                    self.canLoadMore = false
                    return
                }
                
                // 현재 아이템에 새로운 아이템 추가
                self.currentItems.append(contentsOf: list)
                self.pokeList.accept(self.currentItems)
                
                // offset 업데이트
                self.currentOffset += self.limit
                self.isLoading = false
            }, onFailure: { [weak self] error in
                print("Error loading poke list: \(error)")
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
    }
    
    // 초기 로드 또는 새로고침을 위한 메서드
    func refreshPokemonList() {
        currentOffset = 0
        currentItems = []
        canLoadMore = true
        loadMorePokemon()
    }
}
