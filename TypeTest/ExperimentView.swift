//
//  ExperimentView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/23.
//

import SwiftUI

struct ExperimentView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    @State private var name = "さとし"
    @EnvironmentObject var trainerViewModel:TrainerViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("名前 :")
                if editMode?.wrappedValue == .active{
                    TextField("", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                } else {
                    Text(name)
                }
            }
            Spacer()
            EditButton()
        }
    }
}



struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
