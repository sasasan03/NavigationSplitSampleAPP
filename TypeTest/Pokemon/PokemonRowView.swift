//
//  PokemonRowView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/05/06.
//

import SwiftUI

struct PokemonRowView: View {
    
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    @State var pokemonTrainer: PokemonTrainer? = nil
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
                    cancel: { isEddit = false },
                    edit: { trainerName in
                        trainerViewModel.pokemonTrainers[trainerViewModel.trainerIndex(trainer: trainer)].pokemons[trainerViewModel.pokeIndex(pokemonTrainer: trainer, pokemon: pokemon)].name = trainerName
                        update(pokemon)
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
