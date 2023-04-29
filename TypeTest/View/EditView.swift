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
    let pokemonTrainer: PokemonTrainer
    let pokemon: Pokemon
    
    var body: some View {
        List{
            ForEach(pokemonTrainer.pokemons){ pokemon in
                Text(pokemon.name)
            }
            .swipeActions(edge: .trailing) { 
                Button("削除"){
                    trainerViewModel.pokemonDelete(trainer: pokemonTrainer, pokemon: pokemon)
                    print(">>ボタン２")
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
                    let _ = print("+++")
                    trainerViewModel.addPokemon(text: text, trainer: pokemonTrainer)
                    trainerViewModel.isClosePokemonAddView()
                    let _ = print("---")
                }
            )
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
