//
//  OnApperCounter.swift
//  TypeTest
//
//  Created by sako0602 on 2023/04/23.
//

import SwiftUI

struct OnApperCounter: View {
    
    @State var currentText = ""
        let maxTextLength = 15
    
    @State var text: String = "切り替わるよ"
    
    
    var body: some View {
        
        Text(text)
            .padding()
            .task {
                        text = await sleepFunc()
                print("bbbb")
                    }
            .onAppear {
                Task {
                    text = await sleepTaskFunc()
                    print("aaaa")
                }
            }
            .onDisappear{
                text = onDissApper()
            }
        
            
        
        
//        VStack {
//                   Spacer(minLength: 32)
//                   //下が変化を加えたいところ。
//                   //Listにあたる。
//                   Text("入力文字数：\(currentText.count)")
//                   //入力されたところ。
//                   //addViewにあたるところ
//                   TextEditor(text: $currentText)
//                       .onChange(of: currentText) { value in
//                           if value.count > maxTextLength {
//                               currentText.removeLast(currentText.count - maxTextLength)
//                           }
//                       }
//                   Spacer(minLength: 32)
//               }
        
        
        
    }
    
    private func onDissApper() -> String {
        print("消えた")
        return "おんでぃすアピアー"
    }
    
    private func sleepTaskFunc() async -> String {
            sleep(5)
            return ".onAppear"
        }
    
    private func sleepFunc() async -> String {
            sleep(5)
            return ".task"
        }
}

struct OnApperCounter_Previews: PreviewProvider {
    static var previews: some View {
        OnApperCounter()
    }
}
