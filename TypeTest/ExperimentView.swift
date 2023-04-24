//
//  ExperimentView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/23.
//

import SwiftUI

struct ExperimentView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @State var aaa = ["a","b","c"]
    @State var textField: String
    
    var body: some View {
        VStack{
            List(aaa, id: \.self){ a in
                Text(a)
            }
            VStack{
                TextField("文字入力", text: $textField)
                Button {
                    appendAAA(string: textField)
                } label: {
                    Text("追加")
                }
            }
        }
    }
    func appendAAA(string: String){
        aaa.append(string)
    }
//ーーーーーーーーーーーーーーーーーーーーーonChangeのテスト
//            Text("Hello, world!")
//                .padding()
//                .onChange(of: scenePhase) { phase in
//                    switch phase {
//                    case .active:
//                        print("active")
//                    case .inactive:
//                        print("inactive")
//                    case .background:
//                        print("background")
//                    @unknown default:
//                        print("@unknown")
//                    }
//                }
//ーーーーーーーーーーーーーーーーーーーーー
        
}

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView(textField: "")
    }
}
