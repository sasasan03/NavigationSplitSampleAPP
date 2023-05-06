//
//  TextFieldRowView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/05/03.
//

import SwiftUI

struct TextFieldRowView: View {
    
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.editMode) var editMode
    @State var name: String
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    @State private var isWritting = false
    let save: (String) -> Void
    
    var body: some View {
        HStack{
            if isWritting {
                TextField("", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(name)
            }
            Spacer()
            Button {
                isWritting.toggle()
                if !isWritting {
                    save(name)
                }
            } label: {
                Text(isWritting ? "保存" : "編集")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct TextFieldRowView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldRowView(name: "さかき", save: { _  in })
        //pokemonTraioner: PokemonTrainer.init(name: "榊", pokemons: [Pokemon(name: "サイドン")]))
    }
}
