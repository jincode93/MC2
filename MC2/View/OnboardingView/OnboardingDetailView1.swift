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
            Image("OnboardingGif5")
                .resizable()
                .scaledToFit()
            
            Rectangle()
                .fill(Color.black)
                .frame(height: 40)
        }
    }
}

struct OnboardingDetailView1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView1()
    }
}
