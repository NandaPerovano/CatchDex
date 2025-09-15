//
//  GetPokemonsUseCaseModels.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 15/09/25.
//
import Foundation

enum GetPokemonsUseCaseModels {
    struct Data {
        let id: Int
        let name: String
        let imageURL: URL
        let types: [PokemonType]
        
        var mainType: PokemonType {
            types.first ?? .normal
        }
    }
    
    struct Page {
        let total: Int
        let item: [Data]
    }
    
    enum PokemonType: String {
        case bug = "bug"
        case dark = "dark"
        case dragon = "dragon"
        case electric = "electric"
        case fairy = "fairy"
        case fighting = "fighting"
        case fire = "fire"
        case flying = "flying"
        case ghost = "ghost"
        case grass = "grass"
        case ground = "ground"
        case ice = "ice"
        case normal = "normal"
        case poison = "poison"
        case psychic = "psychic"
        case rock = "rock"
        case steel = "steel"
        case water = "water"
        
        init(string value: String?) {
            if let value = value,
               let source = PokemonType(rawValue: value) {
                self = source
            } else {
                self = .normal
            }
        }
    }
    
    enum ErrorData: Error {
        case showErrorScene
    }
}


