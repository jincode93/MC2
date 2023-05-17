//
//  GalleryFrameView.swift
//  MC2
//
//  Created by Jin on 2023/05/17.
//

import SwiftUI

struct GalleryFrameView: View {
    let images: [UIImage]
    @State var duration: TimeInterval
    
    var body: some View {
        GalleryDetailView(images: images, duration: $duration)
            .aspectRatio(contentMode: .fill)
    }
}
