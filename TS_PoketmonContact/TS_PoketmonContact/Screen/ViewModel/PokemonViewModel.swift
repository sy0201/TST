//
//  PokemonViewModel.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import Foundation

final class PokemonViewModel {
    private let repository: PokemonRepository
    var pokemonResponse: PokemonResponse?
    
    var onPokemonData: (() -> Void)?
    
    init(networkService: NetworkService) {
        self.repository = PokemonRepository(networkService: networkService)
    }
    
    func fetchPokemon(frontDefault: Int) {
        repository.fetchPokemon(frontDefault: frontDefault) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemonResponse = success
                self?.onPokemonData?()
                print(self?.pokemonResponse)
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    func randomNumber() -> Int {
        var randomNumber: Int = 0
        for i in 1...1000 {
            
            print(Int.random(in: 1..<1000))
            randomNumber = i
        }
        return randomNumber
    }
}
