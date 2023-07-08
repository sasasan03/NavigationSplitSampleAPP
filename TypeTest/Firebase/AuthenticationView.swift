//
//  AuthenticationView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/06/11.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("email", text: $email)
                TextField("pass word", text: $password)
                Button("ログイン") {
                    //🟥signIn()メソッド。引数に認証対象のメールアドレスとパスワードを渡す。サインインできれば、resultにユーザー情報が格納される。
                    Auth.auth().signIn(withEmail: email, password: password){ result , error in
                        if let user = result?.user {
                            //ログイン時に閲覧できる画面として画面遷移させる
                            print(user,"ログインしました")
                        } else {
                            print("未登録のユーザーです")
                        }
                    }
                }
                NavigationLink("パスワードリセット") {
                    PasswordResetView()
                }
                NavigationLink("未登録の方はこちら"){
                    SignInView()
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
