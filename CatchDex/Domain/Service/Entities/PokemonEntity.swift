//
//  PokemonEntity.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//

import Foundation

enum PokemonEntity {
    
    struct ListData: Codable {
        let count: Int
        let results: [ListItem]
    }
    
    struct ListItem: Codable {
        let name: String
        let url: String
    }
    
    struct DetailData: Codable {
        let id: Int
        let name: String
        let height: Double?
        let weight: Double?
        let types: [PokemonType]
    }
    
    struct PokemonType: Codable {
        let slot: Int
        let type: PokemonDataType
    }
    
    struct PokemonDataType: Codable {
        let name: String
        let url: String
    }
}
