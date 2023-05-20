//
//  Model.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/22.
//

import Foundation

struct Pokemon: Identifiable, Hashable, Codable  {
    var id = UUID()
    var name: String
    var isChecked: Bool
    
    func unchecked() -> Pokemon {
           Pokemon(name: name, isChecked: false)
       }
}

struct PokemonTrainer: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var pokemons: [Pokemon]
    
    func unchecked() -> PokemonTrainer {
            PokemonTrainer(
                name: name, pokemons: pokemons.map { $0.unchecked() }
            )
        }
}

extension Array where Element == PokemonTrainer {
    func unchecked() -> [PokemonTrainer] {
        self.map{ pokemonTrainer in pokemonTrainer.unchecked() }
    }
}


