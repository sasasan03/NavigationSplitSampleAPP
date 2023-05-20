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
                NavigationLink(trainer.name,value: trainer)
            }
            .sheet(isPresented: $isEddit){
                TrainerEditView(
                    trainerName: trainer.name,
                    cancel: { isEddit = false },
                    edit: { trainerName in
                        trainerViewModel.save(trainerName: trainerName, newTrainer: trainer)
                        isEddit = false
                    })
            }
        }
    }
}

struct TopRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopRowView(trainer: PokemonTrainer.init(name: "榊", pokemons: [Pokemon(name: "ニャース", isChecked: false)]), update: { _ in })
    }
}
