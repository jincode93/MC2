//
//  CameraGuide.swift
//  MC2
//
//  Created by Jin on 2023/05/14.
//

import SwiftUI
import AVKit

struct CameraGuideView: View {
    @EnvironmentObject var cameraStore: CameraModel
    @EnvironmentObject var videoStore: VideoStore
    @State var tabSelect: Int
    
    var body: some View {
        GeometryReader { geo in
            TabView(selection: $tabSelect) {
                CameraGuideViewDetail1(width: geo.size.width, height: geo.size.height)
                    .tag(1)
                
                CameraGuideViewDetail2(width: geo.size.width, height: geo.size.height)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
