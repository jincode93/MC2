//
//  SignUpProgressView.swift
//  MC2
//
//  Created by Jin on 2023/05/15.
//

import SwiftUI

struct SignUpProgressView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            ProgressView()
            
            Text("회원가입 중")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                viewRouter.currentPage = "page3"
            }
        }
    }
}

struct SignUpProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpProgressView()
    }
}
