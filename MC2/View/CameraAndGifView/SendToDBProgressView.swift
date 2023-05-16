//
//  SendToDBProgressView.swift
//  MC2
//
//  Created by Jin on 2023/05/11.
//

import SwiftUI

struct SendToDBProgressView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            ProgressView()
            
            Text("이미지 저장 중")
                .font(.title2)
                .foregroundColor(.white)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                viewRouter.currentPage = "page8"
            }
        }
    }
}

struct SendToDBProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SendToDBProgressView()
    }
}
