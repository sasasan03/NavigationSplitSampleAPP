//
//  TypeTestApp.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/18.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
      }
}

@main
struct TypeTestApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SignInView()
//            TopView(pokemon: Pokemon.init(name: "起こりざる", isChecked: false))
//                .environmentObject(TrainerViewModel())
//            TopViewTest(pokemon: Pokemon(name: "???"))
//                .environmentObject(TrainerViewModel())
            
//            ExperimentView(pokemon: Pokemon.init(name: " ごまぞう"))
//                .environmentObject(TrainerViewModel())
        }
    }
}
