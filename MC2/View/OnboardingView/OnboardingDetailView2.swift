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
    @State private var duration: Double = 0.0
    
    var body: some View {
        VStack {
            OnboardingFrameView(images: $images, duration: $duration)
                .scaledToFill()
            
            Rectangle()
                .fill(Color.black)
                .frame(height: 40)
        }
        .onAppear {
            duration = 2.0
        }
        .onDisappear {
            duration = 0.0
        }
    }
}

struct OnboardingDetailView2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView2()
    }
}
