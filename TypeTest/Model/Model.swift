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
}

struct PokemonTrainer: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var pokemons: [Pokemon]
}


