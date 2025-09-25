//
//  PokemonServices.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//

import Foundation

protocol PokemonServiceProvider {
    // Review: Ajusta a função para buscar uma lista de pokémons com paginação. Para isto, adiciona os parâmetros limit e offset para limitar o número de Pokémons recebidos em cada paginação carregada. Neste caso, limit especifica quantos pokémons por página irá carregar por vez e offset, a partir de qual índice.
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonEntity.ListData
    func getPokemon(using id: Int) async throws -> PokemonEntity.DetailData
}

final class PokemonService: PokemonServiceProvider {
    
    // MARK: - Dependencies
    
    private let network: NetworkProvider
    
    // MARK: - Initialization
    
    init(network: NetworkProvider) {
        self.network = network
    }
  
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonEntity.ListData {
        let url = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        return try await network.fetchData(from: url, as: PokemonEntity.ListData.self)
    }
    
    func getPokemon(using id: Int) async throws -> PokemonEntity.DetailData {
        try await network.fetchData(
            from: "https://pokeapi.co/api/v2/pokemon/\(id)",
            as: PokemonEntity.DetailData.self
        )
    }
}

