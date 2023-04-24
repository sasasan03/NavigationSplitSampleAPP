//
//  TrainerViewModel.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/22.
//

import Foundation
//追加されるもの保持する
class TrainerViewModel: ObservableObject {
    
    @Published var isAddView = false
    @Published var isShowPokeAddView = false
    
    @Published var pokemonTrainers = [
        PokemonTrainer(name: "さとる",
                       pokemons: [
                        Pokemon(name:"びかちお"),
                        Pokemon(name: "ぴぽさる"),
                        
                       ]),
        PokemonTrainer(name: "かずみ",
                       pokemons: [
                        Pokemon(name:"とげぴよ"),
                        Pokemon(name: "こだっきゅ")
                       ]),
        PokemonTrainer(name: "たけお",
                       pokemons: [
                        Pokemon(name:"いわへび"),
                        Pokemon(name: "ひろみち")
                       ])
    ]
    //
    
    //コードスニペット。他でも使用可能。スラックなど
    func addTrainer(text: String){
        self.pokemonTrainers.append(PokemonTrainer(name: text, pokemons: []))
        isAddView = false
    }
    
    func isShowTrainerAddView(){
        isAddView = true
    }
    
    func isCloseTrainerAddView(){
        isAddView = false
    }
    //🟨怪しいポイント
    func addPokemon(text: String, trainer: PokemonTrainer){
        //indexを取得。選択したトレーナーを検知し、そのトレーナのポケモンに要素を追加する。
        if let index = pokemonTrainers.firstIndex(of: trainer){
            var updatedTrainer = trainer
            updatedTrainer.pokemons.append(Pokemon(name: text))
            pokemonTrainers[index] = updatedTrainer
        }
        isShowPokeAddView = false
    }
    
    func isShowPokemonAddView(){
        isShowPokeAddView = true
    }
    
    func isClosePokemonAddView(){
        isShowPokeAddView = false
    }
}
