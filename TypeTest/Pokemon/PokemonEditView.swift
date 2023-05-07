//
//  PokemonEditView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/05/06.
//

import SwiftUI

struct PokemonEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var pokemonName: String
    let edit: (String) throws -> Void
    @State private var alert = false
    
    var body: some View {
        NavigationStack{
            HStack{
                Text("ポケモンの名前変更")
                TextField("", text: $pokemonName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        do {
                           try edit(pokemonName)
                            print(">>>>>PE/pokeName", pokemonName) //ピジョンと入力
                            dismiss()
                        } catch {
                            alert = true
                            let error = error as? NonTextError ?? NonTextError.unKnownError
                            print(">>トレーナ空",error.nonTextFieldType)
                        }
                    }
                    .alert("エラー", isPresented: $alert) {
                    } message: {
                        let error = NonTextError.nonTrainerText.nonTextFieldType
                        Text(error)
                    }

                }
            }
        }
    }
}

struct PokemonEditView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonEditView(pokemonName: "ピカ", edit: { _ in })
    }
}
