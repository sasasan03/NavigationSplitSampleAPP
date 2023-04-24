//
//  SwiftUIView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/19.
//

import SwiftUI

struct TopView: View {
    
//    @EnvironmentObject private var trainerViewModel:TrainerViewModel
    @StateObject private var trainerViewModel = TrainerViewModel()
    @State private var selectionTrainer: PokemonTrainer?
    @State private var selectionPokemon: Pokemon?
    
    var body: some View {
        
        NavigationSplitView(sidebar: {
            List(trainerViewModel.pokemonTrainers, selection: $selectionTrainer) { pokemonTrainer in
                NavigationLink(pokemonTrainer.name, value: pokemonTrainer)
                }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        trainerViewModel.isShowTrainerAddView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $trainerViewModel.isAddView) {
                TrainerAddView(
                    cancel: {
                        trainerViewModel.isCloseTrainerAddView()
                    },
                    save: { text in
                    trainerViewModel.addTrainer(text: text)
                    }
                )
            }
        }, detail:{
            if let pokemonTrainer = selectionTrainer {
                EditView(pokemonTrainer: pokemonTrainer)
                    .onDisappear{
                        //  pokemonTrainer.pokemons
                    }
                NavigationLink("アニメーションプラス") {
                    PokemonCheckView(pokemons: pokemonTrainer.pokemons)
                }
            } else {
                Text("ポケモン")
            }
        }
        )
    }
}

struct PokemonCheckView: View{
    
    let pokemons: [Pokemon]
    
    var body: some View {
        List(pokemons) { pokemon in
            HStack {
                Image(systemName: "car")
                Text(pokemon.name)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
