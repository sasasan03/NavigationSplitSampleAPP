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
           // ExperimentView()
            TopView()
                .environmentObject(TrainerViewModel())
         //   OnApperCounter()
        }
    }
}
