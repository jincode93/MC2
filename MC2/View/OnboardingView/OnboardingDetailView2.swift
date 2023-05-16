//
//  OnboardingDetailView2.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI

struct OnboardingDetailView2: View {
    @State private var images: [UIImage] = [UIImage(named: "OnboardingGif1")!,
                                            UIImage(named: "OnboardingGif2")!,
                                            UIImage(named: "OnboardingGif3")!,
                                            UIImage(named: "OnboardingGif4")!]
    var body: some View {
        VStack {
            OnboardingFrameView(images: images, duration: 2.0)
                .scaledToFill()
            
            Rectangle()
                .fill(Color.black)
                .frame(height: 40)
        }
    }
}

struct OnboardingDetailView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView2()
    }
}
