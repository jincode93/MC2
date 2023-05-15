//
//  OnboardingDetailView2.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct OnboardingDetailView2: View {
    var body: some View {
        VStack {
            Text("사진을 찍기만 해도")
                .modifier(ScriptModifier())
            
            HStack {
                Text("하이라이트")
                    .modifier(PointScriptModifier())
                
                Text("댄스를 똑딱")
                    .modifier(ScriptModifier())
            }
            
            Spacer()
            
            Image("OnboardingImage2")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 5 / 8)
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

struct OnboardingDetailView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView2()
    }
}
