//
//  PokemonRowView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/05/06.
//

import SwiftUI

struct PokemonRowView: View {
    
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    let pokemon: Pokemon
    let trainer: PokemonTrainer
    let update: (Pokemon) -> Void
    @State private var isEddit = false
    
    var body: some View {
        NavigationStack{
            HStack{
                Button {
                    isEddit = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle())
                Text(pokemon.name)
            }
            .sheet(isPresented: $isEddit){
                PokemonEditView(
                    pokemonName: pokemon.name,
                    //PokemonEditViewから入力された値（pokeName）が送られてくる。
                    edit: { pokeName in//🟦ちゃんとピジョンになっている
                        let _ = print(">>>>>PR/pokeName", pokeName)//🟦ピジョン
                        let pokeIndex = trainerViewModel.pokeIndex(pokemonTrainer: trainer, pokemon: pokemon)
                        let trainerIndex = trainerViewModel.trainerIndex(trainer: trainer)
                        trainerViewModel.pokemonTrainers[trainerIndex].pokemons[pokeIndex].name = pokeName
                        let _ = print(">>>>>PR/array", trainerViewModel.pokemonTrainers[trainerIndex].pokemons[pokeIndex].name)//🟦ピジョン
                        update(trainerViewModel.pokemonTrainers[trainerIndex].pokemons[pokeIndex])//🟥ポッポ　→　ピジョンになっていないといけないところ
                        let _ = print("#####pokemon", pokemon)
                        isEddit = false
                    })
            }
        }
    }
}

struct PokemonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRowView(pokemon: Pokemon.init(name: "刺身"), trainer: PokemonTrainer.init(name: "ブリ", pokemons: [Pokemon.init(name: "あじ")]), update: { _ in })
    }
}
