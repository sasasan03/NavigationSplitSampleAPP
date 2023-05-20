//
//  ExperimentView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/23.
//

import SwiftUI

struct ExperimentView: View {
    
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    @State private var selectionTrainer: PokemonTrainer?
    let pokemon: Pokemon
    @State var pokemonTrainer: PokemonTrainer? = nil
    @State private var isEdit = false
    
    var body: some View {
        NavigationSplitView(sidebar: {
                List(selection: $selectionTrainer) {
                    ForEach(trainerViewModel.pokemonTrainers){ pokemonTrainer in
                        HStack{
                            Button {
                                self.pokemonTrainer = pokemonTrainer
                            } label: {
                                Text("ボタン")
                                    .foregroundColor(.blue)
                            }
                            Text(pokemonTrainer.name)
                        }
                    }
                }
                .sheet(item: $pokemonTrainer) { pokemonTrainer in
                    TrainerEditView(
                        trainerName: pokemonTrainer.name,
                        cancel: {trainerViewModel.isCloseEditView() },
                        edit: { trainerName in
                            trainerViewModel.pokemonTrainers[trainerViewModel.trainerIndex(trainer: pokemonTrainer)].name = trainerName
                        })
                }
            .onAppear(perform: trainerViewModel.onApper)
        }, detail:{
            if let pokemonTrainer =  trainerViewModel.returnAdress(trainer: selectionTrainer){
                let pokeIndex = trainerViewModel.pokeIndex(pokemonTrainer: pokemonTrainer, pokemon: pokemon)
                let trainerCount = pokemonTrainer.pokemons.count
                if trainerCount != 0 {
                    EditView(pokemonTrainer: pokemonTrainer, pokemon: pokemonTrainer.pokemons[pokeIndex])
                } else {
                    EditView(pokemonTrainer: pokemonTrainer, pokemon: Pokemon(name: "", isChecked: false))
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

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView(pokemon: Pokemon.init(name: "ごまぞう", isChecked: false))
    }
}
