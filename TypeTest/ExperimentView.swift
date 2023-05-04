//
//  ExperimentView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/23.
//

import SwiftUI

struct Animal: Identifiable {
    var id = UUID()
    var name: String
}


struct ExperimentView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    @State private var name = "さとし"
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    @State private var animals = [
        Animal(name: " ひと"),
        Animal(name: "ライオン"),
        Animal(name: " 虎")
    ]
    @State private var isWritting = false
    
    var body: some View {
        VStack {
            List {
                ForEach(animals.indices, id: \.self){ index in
//                    if isWritting {
//                        TextFieldRowView(
//                            name: animals[index].name,
//                            save: { text in
//                                animals[index].name = text
//                            }, pokemonTraioner: PokemonTrainer)
//                    } else {
//                        Text(animals[index].name)
//                    }
                }
            }
            Button(isWritting ? "保存" : "編集"){
                isWritting.toggle()
            }
        }
    }
}



struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
