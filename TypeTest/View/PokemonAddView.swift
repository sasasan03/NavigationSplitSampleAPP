//
//  PokemonAddView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/22.
//

import SwiftUI

struct PokemonAddView: View {
    
    @State private var pokemon = ""
    let cancel: () -> Void
    let save: (String) throws -> Void
    @State private var alert = false
    
    var body: some View {
        NavigationStack{
            HStack{
                Text("ポケモン追加")
                TextField("", text: $pokemon)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("cancel") {
                        cancel()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        do {
                            try save(pokemon)
                        } catch {
                            alert = true
                            let error = error as? NonTextError ?? NonTextError.unKnownError
                            print(">>ポケモン空",error.nonTextFieldType)
                        }
                    }
                    .alert("エラー", isPresented: $alert) {
                    } message: {
                        let error = NonTextError.nonPoekmonText.nonTextFieldType
                        Text(error)
                    }
                }
            }
        }
    }
}

struct PokemonAddView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonAddView(cancel: { }, save: { _ in })
    }
}
