//
//  TopViewTest.swift
//  TypeTest
//
//  Created by sako0602 on 2023/05/03.
//

import SwiftUI

struct TopViewTest: View {
//
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    @State private var selectionTrainer: PokemonTrainer?
    let pokemon: Pokemon
    @State private var name = ""
    @State private var isWritting = false
    
    var body: some View {
        NavigationSplitView(sidebar: {
            VStack {
                List(selection: $selectionTrainer) {
                    ForEach(trainerViewModel.pokemonTrainers){ trainer in
                        if isWritting {
                            TextFieldRowView(name: trainer.name, save: { text in
                                trainerViewModel.pokemonTrainers[trainerViewModel.trainerIndex(trainer: trainer)].name  = text
                            })
                        } else {
                            NavigationLink(
                                trainer.name,
                                value: trainer
                            )
                        }
                    }
                    .onDelete(perform: trainerViewModel.deleteTrainer(offset:))
                    .onMove(perform: trainerViewModel.moveTrainer(indexSet:index:))
                }
                Button {
                    isWritting.toggle()
                } label: {
                    Text(isWritting ? "編集終わり" : "編集する")
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
        }, detail:{
            if let pokemonTrainer =  trainerViewModel.returnAdress(trainer: selectionTrainer){
                let pokeIndex = trainerViewModel.pokeIndex(pokemonTrainer: pokemonTrainer, pokemon: pokemon)
                let trainerCount = pokemonTrainer.pokemons.count
                if trainerCount != 0 {
                    EditView(pokemonTrainer: pokemonTrainer, pokemon: pokemonTrainer.pokemons[pokeIndex])
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

//struct TopViewTest_Previews: PreviewProvider {
//    static var previews: some View {
//        TopViewTest(pokemon: Pokemon(name: "???")
//            .environmentObject(TrainerViewModel())
//    }
//}
