//
//  Model.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/22.
//

import Foundation

struct Pokemon: Identifiable, Hashable {
    let id = UUID()
    //String?は違和感。手持ちを持たずにスタート（必然的に選ぶ動きがあるのならnilあり)するなら空配列の方がよし！
    var name: String
}

struct PokemonTrainer: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var pokemons: [Pokemon]
}
