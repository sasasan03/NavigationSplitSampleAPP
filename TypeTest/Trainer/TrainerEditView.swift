//
//  TrainerEditView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/05/04.
//

import SwiftUI

struct TrainerEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var trainerName: String
    let cancel: () -> Void
    let edit: (String) throws -> Void
    @State private var alert = false
    
    var body: some View {
        NavigationStack{
            HStack{
                Text("トレーナーの名前変更")
                TextField("", text: $trainerName)
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
                           try edit(trainerName)
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

struct TrainerEditView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerEditView(trainerName: "さとし", cancel: { }, edit: { _ in })
    }
}
