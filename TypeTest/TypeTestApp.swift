//
//  TypeTestApp.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/18.
//

import SwiftUI

@main
struct TypeTestApp: App {
    
    var body: some Scene {
        WindowGroup {
           
            TopView(pokemon: Pokemon.init(name: "起こりざる"))
                .environmentObject(TrainerViewModel())
//            TopViewTest(pokemon: Pokemon(name: "???"))
//                .environmentObject(TrainerViewModel())
            
            // ExperimentView()
        }
    }
}
