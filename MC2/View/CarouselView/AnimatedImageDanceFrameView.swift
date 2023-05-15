//
//  AnimatedImageDanceFrameView.swift
//  MC2
//
//  Created by Jin on 2023/05/11.
//

import SwiftUI

struct AnimatedImageDanceFrameView: View {
    @EnvironmentObject var danceStore: DanceStore
    let images: [UIImage]
    let duration: TimeInterval
    var index: Int
    var count: Int
    
    var body: some View {
        ZStack {
            AnimatedImageDanceView(images: images, duration: duration)
                .aspectRatio(contentMode: .fill)
                .zIndex(0)
        }
        .onAppear {
            danceStore.tabIndex = self.index
        }
    }
}
