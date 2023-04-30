//
//  EditView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/22.
//

import SwiftUI

struct EditView: View {
    
    @EnvironmentObject var trainerViewModel: TrainerViewModel
    //    @StateObject private var trainerViewModel = TrainerViewModel()
    var pokemonTrainer: PokemonTrainer
    let pokemon: Pokemon
    
    var body: some View {
        List{
            ForEach(pokemonTrainer.pokemons){ pokemon in
                Text(pokemon.name)
            }
            .onMove { sourceIndices, destinationIndx in
                  pokemonTrainer.pokemons.move(fromOffsets: sourceIndices, toOffset: destinationIndx)
            }
            .swipeActions(edge: .trailing) {
                Button {
                    trainerViewModel.pokemonDelete(trainer: pokemonTrainer, pokemon: pokemon)
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
                    trainerViewModel.addPokemon(text: text, trainer: pokemonTrainer)
                    trainerViewModel.isClosePokemonAddView()
                }
            )
        }
    }
    mutating func move(indexSet:IndexSet, int: Int) {
        pokemonTrainer.pokemons.move(fromOffsets: indexSet, toOffset: int)
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView()
//            .environment(trainerViewModel:TrainerViewModel)
//        EditView(pokemonTrainer: PokemonTrainer(name: "わたる", pokemons: [Pokemon(name: "魁龍")]))
//    }
//}
