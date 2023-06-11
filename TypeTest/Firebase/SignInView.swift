//
//  SignInView.swift
//  TypeTest
//
//  Created by sako0602 on 2023/06/10.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            TextField("太郎", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField("xxx.xxx@gmail.com", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField("パスワード", text: $password)
                .padding()
                .textFieldStyle(.roundedBorder)
            Button("新規登録"){
                //🟥createUserメソッドを使用してemailとpasswordが正しく入力されているか検証を行う。
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    print("1️⃣", result)
                    guard let user = result?.user else { return }
                    //🟥createProfileChangeRequestメソッドを使用してリクエストを作成する。ユーザー変更リクエストが帰る。リクエストを作成しただけ。
                    let request = user.createProfileChangeRequest()
                    request.displayName = name
                    //🟥commitChangeメソッドを使用して、実際にリクエストを反映させる。
                    request.commitChanges(){ error in
                        if error == nil {
                            //アドレス確認メールはsendEmailVerificatuinメソッドを使用。確認メールが送られる
                            user.sendEmailVerification(){ error in
                                if error == nil {
                                    print("仮登録画面へ")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
