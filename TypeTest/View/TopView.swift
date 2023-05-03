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
    @State private var name = ""
    
    var body: some View {
        NavigationSplitView(sidebar: {
            VStack {
                List(selection: $selectionTrainer) {
                    ForEach(trainerViewModel.pokemonTrainers){ pokemonTrainer in
                            NavigationLink(pokemonTrainer.name, value: pokemonTrainer)//🟨
                        }
                    
                    .onDelete(perform: trainerViewModel.deleteTrainer(offset:))
                    .onMove(perform: trainerViewModel.moveTrainer(indexSet:index:))
                }
                
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
                    try trainerViewModel.addTrainer(text: text)
                    }
                )
               
            }
            .onAppear(perform: trainerViewModel.onApper)
           //🟥 .presentationDetents([.height(10)])
        }, detail:{
            if let pokemonTrainer =  trainerViewModel.returnAdress(trainer: selectionTrainer){
                let pokeIndex = trainerViewModel.pokeIndex(pokemonTrainer: pokemonTrainer, pokemon: pokemon)
                let trainerCount = pokemonTrainer.pokemons.count
                if trainerCount != 0 {
                    EditView(pokemonTrainer: pokemonTrainer, pokemon: pokemonTrainer.pokemons[pokeIndex])
                } else {
                    //Empty
                    Image(systemName: "car")
                   // EditView(pokemonTrainer: pokemonTrainer, pokemon: Pokemon(name: ""))
                }
//                if pokemonTrainer.name.isEmpty {
//                    EditView(pokemonTrainer: pokemonTrainer, pokemon: Pokemon(name: ""))
//                } else {
//                    //Empty
//                    EditView(pokemonTrainer: pokemonTrainer, pokemon: pokemonTrainer.pokemons[pokeIndex])
//                }
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
                Image(systemName: "photo.fill")
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
