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
            Image("OnboardingGif6")
                .resizable()
                .scaledToFit()
            
            Rectangle()
                .fill(Color.black)
                .frame(height: 40)
        }
    }
}

struct OnboardingDetailView3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView3()
    }
}
