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
    //UserDefaultでデータをデバイスに保存する処理を追加していく。
    private let userDefaultManager = UserDefaultManager()
    
    func trainerIndex(trainer: PokemonTrainer) -> Int {
        guard let trainerIndex = pokemonTrainers.firstIndex(where: { $0.id == trainer.id }) else { return 0 }
        return trainerIndex
    }
    
    func pokeIndex(pokemonTrainer: PokemonTrainer, pokemon: Pokemon) -> Int {
        guard  let pokeIndex = pokemonTrainer.pokemons.firstIndex(where: {
             $0.id == pokemon.id
        }) else { return 0 }
        return pokeIndex
    }
    
    //どこでこの関数を使うのか?EditViewのonMove内で使用したい。
    func pokeArray(trainer: PokemonTrainer) -> [Pokemon]{
        let pokeArray = pokemonTrainers[trainerIndex(trainer: trainer)].pokemons
        return pokeArray
    }
    
    //ポケモンの並び替えに使用
//    func movePoke(indexSet: IndexSet, index: Int, trainer: PokemonTrainer){
//        let trainerIndex = trainerIndex(trainer: trainer)
//        self.pokemonTrainers[trainerIndex].pokemons.move(fromOffsets: indexSet, toOffset: index)
//        do {
//            try userDefaultManager.save(trainer: pokemonTrainers)
//        } catch {
//            let error = error as? DataConvertError ?? DataConvertError.unknown
//            print(error.title)
//        }
//    }
    
    //トレーナーの並び替えに使用
    func moveTrainer(indexSet: IndexSet, index: Int){
        self.pokemonTrainers.move(fromOffsets: indexSet, toOffset: index)
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    //ポケモンの要素を削除するために使用
    func pokemonDelete(trainer: PokemonTrainer, pokemon: Pokemon)  {
        guard let trainerIndex = pokemonTrainers.firstIndex(where: { $0.id == trainer.id }) else { return print("値なし1")}
        guard let pokemonIndex = pokemonTrainers[trainerIndex].pokemons.firstIndex(where: { $0.id == pokemon.id }) else { return print("値なし2") }
        pokemonTrainers[trainerIndex].pokemons.remove(at: pokemonIndex)
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    func delete(offset: IndexSet){
        self.pokemonTrainers.remove(atOffsets: offset)
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //シート入力した値をエンコード。
    func updale(newTrainer: PokemonTrainer) {
        guard let index = pokemonTrainers.firstIndex(where: { $0.id == newTrainer.id }) else { return }
        pokemonTrainers[index] = newTrainer
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //アプリ起動時に保存されていた配列のデータを呼ぶ
    func onApper(){
        do {
            let savedTrainers = try userDefaultManager.load()
            pokemonTrainers = savedTrainers
        } catch {
            let  error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    func addTrainer(text: String){
        self.pokemonTrainers.append(PokemonTrainer(name: text, pokemons: []))
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
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
            pokemonTrainers[index] = updatedTrainer
        }
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
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
