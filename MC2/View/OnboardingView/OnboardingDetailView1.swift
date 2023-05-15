//
//  OnboardingDetailView1.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct OnboardingDetailView1: View {
    var body: some View {
        VStack {
            Text("어려운 춤, 쉽고 재미있게")
                .modifier(ScriptModifier())
                
            HStack {
                Text("DDOK DDAK")
                    .modifier(PointScriptModifier())
                
                Text("하세요!")
                    .modifier(ScriptModifier())
            }
            
            Spacer()
            
            Image("OnboardingImage1")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 5 / 8)
            
            Spacer()
        }
        .padding(.top, 20)
    }
}

struct OnboardingDetailView1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView1()
    }
}
