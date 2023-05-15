//
//  AnimatedImageFrameView.swift
//  MC2
//
//  Created by Jin on 2023/05/11.
//

import SwiftUI

struct AnimatedImageFrameView: View {
    let images: [UIImage]
    let duration: TimeInterval
    
    var body: some View {
        AnimatedImageView(images: images, duration: duration)
            .aspectRatio(contentMode: .fill)
    }
}
