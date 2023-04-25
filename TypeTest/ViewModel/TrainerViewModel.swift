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

    func addPokemon(text: String, trainer: PokemonTrainer){
        //indexを取得。選択したトレーナーを検知し、そのトレーナのポケモンに要素を追加する。
        if let index = pokemonTrainers.firstIndex(of: trainer){
            var updatedTrainer = trainer
            updatedTrainer.pokemons.append(Pokemon(name: text))
            print("<<<<<<",updatedTrainer.pokemons)
            pokemonTrainers[index] = updatedTrainer
            print(">>>pokeAdd", pokemonTrainers[index])
        }
        isClosePokemonAddView()
    }
    
    func returnAdress(trainer: PokemonTrainer?) -> PokemonTrainer? {
        guard let trainer = trainer else {
            return nil
        }
        //取得してきたトレーナーのIDを検索してポケモンを返す。
        guard let index = pokemonTrainers.firstIndex(where: { $0.id == trainer.id }) else { return nil }
                
        return pokemonTrainers[index]
    }
    
    func isShowPokemonAddView(){
        isShowPokeAddView = true
    }
    
    func isClosePokemonAddView(){
        isShowPokeAddView = false
    }
}
