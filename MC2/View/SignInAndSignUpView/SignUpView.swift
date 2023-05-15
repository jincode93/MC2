//
//  SignUpView.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("회원가입")
                    .modifier(TitleModifier())
                
                VStack {
                    TextField(text: $userStore.nickName) {
                        Text("닉네임")
                            .foregroundColor(.stringColor)
                    }
                    .textFieldStyle(UnderlinedTextFieldStyle())
                    
                    ZStack {
                        TextField(text: $userStore.signUpEmail) {
                            Text("이메일 주소")
                                .foregroundColor(.stringColor)
                        }
                        .textFieldStyle(UnderlinedTextFieldStyle())
                        
                        HStack {
                            Spacer()
                            Button {
                                // 중복확인 버튼
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.mainColor)
                                    .frame(width: 90, height: 34)
                                    .overlay {
                                        Text("중복확인")
                                            .foregroundColor(.stringColor)
                                            .font(.callout)
                                    }
                            }
                            .padding(.bottom, 20)
                            .padding(.trailing, 10)
                        }
                    }
                    
                    SecureField(text: $userStore.signUpPW) {
                        Text("비밀번호")
                            .foregroundColor(.stringColor)
                    }
                    .textFieldStyle(UnderlinedTextFieldStyle())
                    
                    SecureField(text: $userStore.signUpPWCheck) {
                        Text("비밀번호 확인")
                            .foregroundColor(.stringColor)
                    }
                    .textFieldStyle(UnderlinedTextFieldStyle())
                }
                .padding(.vertical, 30)
                
                Button {
                    viewRouter.currentPage = "signUpProgress"
                    userStore.createNewAccount()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        if userStore.signCheck == true {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                } label: {
                    Text("회원가입")
                        .modifier(LongButtonModifier(backgroundColor: .blue))
                }
 
                Spacer()
            } // VStack
        } // ZStack
    } // body
} // struct

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
