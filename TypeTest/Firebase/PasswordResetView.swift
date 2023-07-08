//
//  PasswordResetView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/06/11.
//

import SwiftUI
import FirebaseAuth

struct PasswordResetView: View {
    
    @State var email = ""
    
    var body: some View {
        VStack {
            TextField("email address", text: $email)
            Button("パスワードリセット メール送信"){
                Auth.auth().sendPasswordReset(withEmail: email){ error in
                    
                }
            }
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}
