//
//  TrainerAdd.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/22.
//

import SwiftUI

struct TrainerAddView: View {
    
    @State private var trainer = ""
    let cancel: () -> Void
    let save: (String) throws -> Void
    @State private var alert = false
    
    var body: some View {
        NavigationStack{
            HStack{
                Text("トレーなー追加")
                TextField("", text: $trainer)
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
                           try save(trainer)
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

struct TrainerAddView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerAddView(cancel: {}, save: { _ in })
    }
}
