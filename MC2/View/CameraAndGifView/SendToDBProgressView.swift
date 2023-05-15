//
//  SendToDBProgressView.swift
//  MC2
//
//  Created by Jin on 2023/05/11.
//

import SwiftUI

struct SendToDBProgressView: View {
    var body: some View {
        VStack {
            ProgressView()
            
            Text("이미지 저장 중")
                .font(.title2)
                .foregroundColor(.white)
        }
    }
}

struct SendToDBProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SendToDBProgressView()
    }
}
