//
//  AuthenticationView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/06/11.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("email", text: $email)
            TextField("pass word", text: $password)
            Button("ログイン") {
                
            }
            Button("パスワードリセット") {
                
            }
            Button("未登録の方はこちら") {
                
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
