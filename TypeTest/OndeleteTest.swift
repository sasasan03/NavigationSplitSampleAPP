//
//  OndeleteTest.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/26.
//

import SwiftUI

struct OndeleteTest: View {
    
    @State private var links: [String] = ["Link 1", "Link 2", "Link 3"]

    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(links, id: \.self){ link in
                    NavigationLink(destination: Text(link)) {
                        Text(link)
                    }
                }
                .onDelete { indexSet in
                    links.remove(atOffsets: indexSet)
                }
            }
        }
    }
}

struct OndeleteTest_Previews: PreviewProvider {
    static var previews: some View {
        OndeleteTest()
    }
}
