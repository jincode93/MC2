//
//  OnboardingDetailView3.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct OnboardingDetailView3: View {
    var body: some View {
        VStack {
            HStack {
                Text("뚝딱이에서")
                    .modifier(ScriptModifier())
                
                HStack(spacing: 0) {
                    Text("똑딱이")
                        .modifier(PointScriptModifier())
                    
                    Text("로")
                        .modifier(ScriptModifier())
                }
            }
            
            Text("성장하는 나를 발견해봐요")
                .modifier(ScriptModifier())
            
            Spacer()
            
            Image("OnboardingImage3")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 5 / 8)
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

struct OnboardingDetailView3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView3()
    }
}
