//
//  SignInView.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userStore: UserStore
    
    @State var isLoginButtonToggle: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if isLoginButtonToggle == false {
                    VStack {
                        Text("로그인")
                            .modifier(TitleModifier())
                        
                        VStack {
                            TextField(text: $userStore.email) {
                                Text("이메일 주소")
                                    .foregroundColor(.stringColor)
                            }
                            .textFieldStyle(UnderlinedTextFieldStyle())
                            
                            SecureField(text: $userStore.pw) {
                                Text("비밀번호")
                                    .foregroundColor(.stringColor)
                            }
                            .textFieldStyle(UnderlinedTextFieldStyle())
                        }
                        .padding(.vertical, 30)
                        
                        Button {
                            Task {
                                isLoginButtonToggle = true
                                await userStore.signInUser()
                                await userStore.userWillFetchDB()
                                viewRouter.currentPage = "page4"
                                await userStore.userMusicWillFetchDB(userId: userStore.currentUserUid)
                            }
                        } label: {
                            Text("로그인")
                                .modifier(LongButtonModifier())
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("DDOK DDAK이 처음이신가요?")
                                .font(.callout)
                                .foregroundColor(.stringColor)
                            
                            NavigationLink {
                                SignUpView()
                                    .environmentObject(userStore)
                            } label: {
                                Text("가입하기")
                                    .font(.callout)
                                    .foregroundColor(.pointColor)
                            }
                        }
                    }
                } else {
                    VStack {
                        ProgressView()
                        
                        Text("로그인 중")
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(.white)
                }
            } // ZStack
        } // navigationView
    } // body
} // struct

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
