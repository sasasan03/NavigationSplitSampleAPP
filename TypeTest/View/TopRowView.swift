//
//  TopRowView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/05/04.
//

import SwiftUI

struct TopRowView: View {
    
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    @State var pokemonTrainer: PokemonTrainer? = nil
    let trainer: PokemonTrainer
    let update: (PokemonTrainer) -> Void
    
    var body: some View {
        NavigationStack{
            HStack{
                Button {
                    pokemonTrainer = trainerViewModel.pokemonTrainers[trainerViewModel.trainerIndex(trainer: trainer)]
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle())
                NavigationLink(trainer.name,value: trainer)
            }
            .sheet(item: $pokemonTrainer) { pokemonTrainer in
                TrainerEditView(
                    trainerName: pokemonTrainer.name,
                    cancel: {trainerViewModel.isCloseEditView() },
                    edit: { trainerName in
                        trainerViewModel.pokemonTrainers[trainerViewModel.trainerIndex(trainer: pokemonTrainer)].name = trainerName
                    })
            }
        }
    }
}

struct TopRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopRowView(pokemonTrainer: PokemonTrainer.init(name: "榊", pokemons: [Pokemon(name: "サイドン")]), trainer: PokemonTrainer(name: "かすみ", pokemons: [Pokemon(name: "トゲピ")]), update: { _ in })
    }
}
