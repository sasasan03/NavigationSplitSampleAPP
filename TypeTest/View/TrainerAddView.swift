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
    let save: (String) -> Void
    
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
                        save(trainer)
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
