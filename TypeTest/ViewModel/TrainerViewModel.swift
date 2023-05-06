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
    @Published var isEdditView = false
    
    
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
    
    //TopViewでSidebarから渡されてきたトレーナーが持っているポケモンのIndexを取得するために使用
    func pokeIndex(pokemonTrainer: PokemonTrainer, pokemon: Pokemon) -> Int {
        guard  let pokeIndex = pokemonTrainer.pokemons.firstIndex(where: {
             $0.id == pokemon.id
        }) else { return 0 }
        return pokeIndex
    }
//-----------------------------------------------------EditViewないでポケモンの場所を変更させるために使用
    //movePokeメソッドで内で、渡されてきたトレーナーのIntを検索するために使用🟦以下成功コード
    func trainerIndex(trainer: PokemonTrainer) -> Int {
        guard let trainerIndex = pokemonTrainers.firstIndex(where: { $0.id == trainer.id }) else { return 0 }
        return trainerIndex
    }
    
    //pokemonの場所を変更させるために使用する
    func movePoke(indexSet: IndexSet, index: Int, trainer: PokemonTrainer){
        let trainerIndex = trainerIndex(trainer: trainer)
        self.pokemonTrainers[trainerIndex].pokemons.move(fromOffsets: indexSet, toOffset: index)
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
//------------------------------------------------------
    //トレーナーの場所を変更させるために使用する
    func moveTrainer(indexSet: IndexSet, index: Int){
        self.pokemonTrainers.move(fromOffsets: indexSet, toOffset: index)
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    //ポケモンの要素を削除するために使用する
    func deletePokemon(trainer: PokemonTrainer, pokemon: Pokemon)  {
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
    
    //トレーナの要素を削除するために使用する
    func deleteTrainer(offset: IndexSet){
        self.pokemonTrainers.remove(atOffsets: offset)
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
    
    //トレーナー配列に新しいトレーナーを追加するために使用
    func addTrainer(text: String) throws {
        guard text != "" else {
            throw NonTextError.nonTrainerText
        }
        self.pokemonTrainers.append(PokemonTrainer(name: text, pokemons: []))
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
        isAddView = false
    }
    
    //TrainerAddViewを開かせる
    func isShowTrainerAddView(){
        isAddView = true
    }
    //TrainerAddViewを閉じさせる
    func isCloseTrainerAddView(){
        isAddView = false
    }

    //選択したトレーナーに新しいポケモンを追加するために使用
    func addPokemon(text: String, trainer: PokemonTrainer) throws {
        //indexを取得。選択したトレーナーを検知し、そのトレーナのポケモンに要素を追加する。
        if let index = pokemonTrainers.firstIndex(of: trainer){
            var updatedTrainer = trainer
            guard text != "" else {
                throw NonTextError.nonPoekmonText
            }
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
    
    //detailViewへ渡させたポケモントレーナー情報を配列の中から検索し、一致したトレーナーの情報を返すために使用
    func returnAdress(trainer: PokemonTrainer?) -> PokemonTrainer? {
        guard let trainer = trainer else {
            return nil
        }
        //取得してきたトレーナーのIDを検索してポケモンを返す。
        guard let index = pokemonTrainers.firstIndex(where: { $0.id == trainer.id }) else { return nil }
                
        return pokemonTrainers[index]
    }
    
    //PokemonAddViewを開くために使用
    func isShowPokemonAddView(){
        isShowPokeAddView = true
    }
    
    //PokemonAddViewを閉じるために使用
    func isClosePokemonAddView(){
        isShowPokeAddView = false
    }
    
    //EditViewを非表示にする
    func isCloseEditView(){
        isEdditView = false
    }
    
    //EditViewを表示する
    func isShowEditView(){
        isEdditView = true
    }
    
    //EditViewで入力された値を保存した後に非表示にする
    func saveEditView(trainer: PokemonTrainer){
        updale(newTrainer: trainer)
        isCloseEditView()
    }
    
    func save(trainerName: String, newTrainer: PokemonTrainer){
        guard let index = pokemonTrainers.firstIndex(where: { $0.id == newTrainer.id }) else { return }
        pokemonTrainers[index] = newTrainer
        
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    //アドホック多層saveの引数が違う
    func save(of newTrainer: PokemonTrainer){
        guard let index = pokemonTrainers.firstIndex(where: { $0.id == newTrainer.id }) else { return }
        pokemonTrainers[index] = newTrainer
        
        do {
            try userDefaultManager.save(trainer: pokemonTrainers)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    func getName<T>(of t: T) -> String {
        if let person = t as? PokemonTrainer {
          return ""//  return person.firstName + " " + person.lastName
        } else if let book = t as? Pokemon {
           return "" //return book.title
        } else {
            return ""
        }
    }
    
    //渡されてきたトレーナーの名前や持っているポケモンを新しく保存するために使用
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
}
