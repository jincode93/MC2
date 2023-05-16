//
//  OnboardingFrameView.swift
//  MC2
//
//  Created by Jin on 2023/05/16.
//

import SwiftUI

struct OnboardingFrameView: View {
    @State var images: [UIImage]
    @State var duration: Double
    
    var body: some View {
        ZStack {
            AnimatedImageDanceView(images: images, duration: duration)
                .aspectRatio(contentMode: .fill)
        }
    }
}
