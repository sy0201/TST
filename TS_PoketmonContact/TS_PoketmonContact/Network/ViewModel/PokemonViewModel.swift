//
//  PokemonViewModel.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import Foundation

final class PokemonViewModel {
    private let repository: PokemonRepository
    var pokemonResponse: PokemonResponse? {
        didSet {
            onPokemonData?()
        }
    }
    var onPokemonData: (() -> Void)?
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func fetchRandomPokemon() {
        let randomInt = Int.random(in: 1...1000)
        
        repository.fetchPokemon(frontDefault: randomInt) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemonResponse = success
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getPokemonImageURL() -> String? {
        return pokemonResponse?.sprites.frontDefault
    }
}
