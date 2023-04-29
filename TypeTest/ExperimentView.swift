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
    @State var items = [[1,2,3], [4,5,6], [7,8,9]]
    
    var body: some View {
      
            

                List {
                    ForEach(items.indices, id: \.self) { index in
                        HStack {
                            ForEach(items[index], id: \.self) { item in
                                Text("\(item)")
                            }
                        }
                        .contextMenu {
                            Button("Remove 1") {
                                self.items[index].removeAll { $0 == 1 }
                            }
                        }
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
