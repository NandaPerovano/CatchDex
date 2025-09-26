//
//  PokemonsModels.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//

import Foundation
import UIKit

enum PokemonsScene {
    
    enum Response {
        case loading
        case error
        case success([GetPokemonsUseCaseModels.Data])
    }
    
    enum ViewState {
        case loading
        case error
        case success([ViewData])
    }
    
    struct ViewData {
        let id: Int
        let name: String
        let imageURL: URL
        let backgroundColor: UIColor
        let types: [ViewDataType]
        
        var identifier: String {
            String(format: "%03d", id)
        }
    }
    
    struct ViewDataType {
        let name: String
        let image: UIImage
        let backgroundColor: UIColor
    }
}

extension GetPokemonsUseCaseModels.PokemonType {
    
    var color: UIColor {
        switch self {
        case .bug: return UIColor(red: 140/255, green: 178/255, blue: 48/255, alpha: 1)
        case .dark: return UIColor(red: 88/255, green: 87/255, blue: 95/255, alpha: 1)
        case .dragon: return UIColor(red: 15/255, green: 106/255, blue: 192/255, alpha: 1)
        case .electric: return UIColor(red: 238/255, green: 213/255, blue: 53/255, alpha: 1)
        case .fairy: return UIColor(red: 237/255, green: 110/255, blue: 199/255, alpha: 1)
        case .fighting: return UIColor(red: 208/255, green: 65/255, blue: 100/255, alpha: 1)
        case .fire: return UIColor(red: 253/255, green: 125/255, blue: 36/255, alpha: 1)
        case .flying: return UIColor(red: 116/255, green: 143/255, blue: 201/255, alpha: 1)
        case .ghost: return UIColor(red: 85/255, green: 106/255, blue: 174/255, alpha: 1)
        case .grass: return UIColor(red: 98/255, green: 185/255, blue: 87/255, alpha: 1)
        case .ground: return UIColor(red: 221/255, green: 119/255, blue: 72/255, alpha: 1)
        case .ice: return UIColor(red: 97/255, green: 206/255, blue: 192/255, alpha: 1)
        case .normal: return UIColor(red: 157/255, green: 160/255, blue: 170/255, alpha: 1)
        case .poison: return UIColor(red: 165/255, green: 82/255, blue: 204/255, alpha: 1)
        case .psychic: return UIColor(red: 234/255, green: 93/255, blue: 96/255, alpha: 1)
        case .rock: return UIColor(red: 186/255, green: 171/255, blue: 130/255, alpha: 1)
        case .steel: return UIColor(red: 65/255, green: 125/255, blue: 154/255, alpha: 1)
        case .water: return UIColor(red: 74/255, green: 144/255, blue: 218/255, alpha: 1)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .bug: return UIColor(red: 139/255, green: 214/255, blue: 116/255, alpha: 1)
        case .dark: return UIColor(red: 111/255, green: 110/255, blue: 120/255, alpha: 1)
        case .dragon: return UIColor(red: 115/255, green: 131/255, blue: 185/255, alpha: 1)
        case .electric: return UIColor(red: 242/255, green: 203/255, blue: 85/255, alpha: 1)
        case .fairy: return UIColor(red: 235/255, green: 168/255, blue: 195/255, alpha: 1)
        case .fighting: return UIColor(red: 235/255, green: 73/255, blue: 113/255, alpha: 1)
        case .fire: return UIColor(red: 255/255, green: 167/255, blue: 86/255, alpha: 1)
        case .flying: return UIColor(red: 131/255, green: 162/255, blue: 227/255, alpha: 1)
        case .ghost: return UIColor(red: 133/255, green: 113/255, blue: 190/255, alpha: 1)
        case .grass: return UIColor(red: 139/255, green: 190/255, blue: 138/255, alpha: 1)
        case .ground: return UIColor(red: 247/255, green: 133/255, blue: 81/255, alpha: 1)
        case .ice: return UIColor(red: 97/255, green: 206/255, blue: 192/255, alpha: 1)
        case .normal: return UIColor(red: 181/255, green: 185/255, blue: 196/255, alpha: 1)
        case .poison: return UIColor(red: 159/255, green: 110/255, blue: 151/255, alpha: 1)
        case .psychic: return UIColor(red: 255/255, green: 101/255, blue: 104/255, alpha: 1)
        case .rock: return UIColor(red: 212/255, green: 194/255, blue: 148/255, alpha: 1)
        case .steel: return UIColor(red: 76/255, green: 145/255, blue: 178/255, alpha: 1)
        case .water: return UIColor(red: 88/255, green: 171/255, blue: 246/255, alpha: 1)
        }
    }
    
    var icon: UIImage {
        switch self {
        case .bug: return Asset.iconBug.image
        case .dark: return Asset.iconDark.image
        case .dragon: return Asset.iconDragon.image
        case .electric: return Asset.iconElectric.image
        case .fairy: return Asset.iconFairy.image
        case .fighting: return Asset.iconFighting.image
        case .fire: return Asset.iconFire.image
        case .flying: return Asset.iconFlying.image
        case .ghost: return Asset.iconGhost.image
        case .grass: return Asset.iconGrass.image
        case .ground: return Asset.iconGround.image
        case .ice: return Asset.iconIce.image
        case .normal: return Asset.iconNormal.image
        case .poison: return Asset.iconPoison.image
        case .psychic: return Asset.iconPsychic.image
        case .rock: return Asset.iconRock.image
        case .steel: return Asset.iconSteel.image
        case .water: return Asset.iconWater.image
        }
    }
}
