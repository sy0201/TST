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
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func fetchRandomPokemon() {
        let randomInt = Int.random(in: 1...1000)
        
        repository.fetchPokemon(frontDefault: randomInt) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemonResponse = success
                self?.onPokemonData?()
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    func getPokemonResponse() -> PokemonResponse? {
        return pokemonResponse
    }
    
    func setPokemonResponse(_ newResponse: PokemonResponse) {
        self.pokemonResponse = newResponse
    }
}
