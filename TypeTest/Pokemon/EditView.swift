//
//  EditView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/22.
//

import SwiftUI

struct EditView: View {
    
//    @StateObject private var trainerViewModel = TrainerViewModel()
    @EnvironmentObject var trainerViewModel: TrainerViewModel
    let pokemonTrainer: PokemonTrainer
    let pokemon: Pokemon
    @State var isEdit = false
    
    var body: some View {
        List{
            ForEach(pokemonTrainer.pokemons){ pokemon in
                PokemonRowView(pokemon: pokemon,
                               trainer: pokemonTrainer,
                               update: { text in
                    trainerViewModel.save(trainerName: text.name, newTrainer: pokemonTrainer)
                })
//                HStack{
//                    Button {
//                        isEdit = true
//                    } label: {
//                        Image(systemName: "info.circle.fill")
//                    }
//                    Text(pokemon.name)
//                }
                
            }
            .onMove { sourceIndices, destinationIndx in
                trainerViewModel.movePoke(indexSet: sourceIndices, index: destinationIndx, trainer: pokemonTrainer)
            }
            .swipeActions(edge: .trailing) {
                Button {
                    trainerViewModel.deletePokemon(trainer: pokemonTrainer, pokemon: pokemon)
                } label: {
                    Image(systemName: "trash.fill")
                }
                .tint(.red)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    trainerViewModel.isShowPokemonAddView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $trainerViewModel.isShowPokeAddView) {
            PokemonAddView(
                cancel: {
                    trainerViewModel.isClosePokemonAddView()
                },
                save: { text in
                   try trainerViewModel.addPokemon(text: text, trainer: pokemonTrainer)
                    trainerViewModel.isClosePokemonAddView()
                }
            )
        }
        .sheet(isPresented: $isEdit){
            
        }
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView()
//            .environment(trainerViewModel:TrainerViewModel)
//        EditView(pokemonTrainer: PokemonTrainer(name: "わたる", pokemons: [Pokemon(name: "魁龍")]))
//    }
//}
