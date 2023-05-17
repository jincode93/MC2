//
//  OnboardingDetailView4.swift
//  MC2
//
//  Created by Jin on 2023/05/16.
//

import SwiftUI

struct OnboardingDetailView4: View {
    @State private var images: [UIImage] = [UIImage(named: "OnboardingGif5")!,
                                            UIImage(named: "OnboardingGif6")!,
                                            UIImage(named: "OnboardingGif7")!,
                                            UIImage(named: "OnboardingGif8")!]
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

struct OnboardingDetailView4_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetailView4()
    }
}
