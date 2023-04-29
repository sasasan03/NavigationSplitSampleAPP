//
//  ExperimentView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/23.
//

import SwiftUI

struct ExperimentView: View {
    
    @State private var fruits = [
        "Apple",
        "Banana",
        "Papaya",
        "Mango"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                }
                .onDelete { fruits.remove(atOffsets: $0) }
                .onMove { fruits.move(fromOffsets: $0, toOffset: $1) }
            }
            .navigationTitle("Fruits")
            .toolbar {
                EditButton()
            }
        }
        
    }
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
struct ListView: View {
  @State var names = ["First", "Second", "Third"]
  
  var body: some View {
    VStack {
      List(names, id:\.self) { name in
        Text(name)
      }
      .navigationBarTitle("List only")
    }
    .navigationBarItems(trailing: EditButton())
    .padding()
  }
}

struct ListForEachView: View {
  @State var names = ["First", "Second", "Third"]

  var body: some View {
      VStack {
        List {
          ForEach(names, id: \.self) { name in
            Text(name)
          }
          .onDelete(perform: { indexSet in
            names.remove(at: indexSet.first!)
          })
        }
        .navigationBarTitle("Names")
      }
      .navigationBarItems(trailing: EditButton())
      .padding()
  }
}


struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
