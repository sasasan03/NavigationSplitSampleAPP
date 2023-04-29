//
//  SwiftUIView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/19.
//

import SwiftUI

struct TopView: View {
//    @StateObject var trrainerViewMOdel: TrainerAddView?
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    @State private var selectionTrainer: PokemonTrainer?
    @State private var selectionPokemon: Pokemon?
    let pokemon: Pokemon
    
    var body: some View {
        
        NavigationSplitView(sidebar: {
                List(selection: $selectionTrainer) {
                    ForEach(trainerViewModel.pokemonTrainers){ pokemonTrainer in
                        NavigationLink(pokemonTrainer.name, value: pokemonTrainer)
                    }
                    .onDelete(perform: trainerViewModel.delete(offset: ))
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
            .onAppear(perform: trainerViewModel.onApper)
           //🟥 .presentationDetents([.height(10)])
        }, detail:{
            if let pokemonTrainer =  trainerViewModel.returnAdress(trainer: selectionTrainer){
                var index = pokemonTrainer.pokemons.count
                if index != 0 {
                    EditView(pokemonTrainer: pokemonTrainer, pokemon: pokemonTrainer.pokemons[index - 1])
                } else {
                    EditView(pokemonTrainer: pokemonTrainer, pokemon: Pokemon(name: ""))
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
        TopView(pokemon: Pokemon(name: "???"))
            .environmentObject(TrainerViewModel())
    }
}
