//
//  PartSellectedVideoView.swift
//  MC2
//
//  Created by Jin on 2023/05/17.
//

import SwiftUI
import AVKit

struct PartSellectedVideoView: View {
    @StateObject var videoStore = VideoStore()
    var musicTitle: String
    var partIndex: Int
    
    var body: some View {
        ZStack {
            if let player = videoStore.player {
                VideoPlayer(player: player)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                    .cornerRadius(20)
            } else {
                Text("비디오 로딩을 실패했습니다.🥲")
                    .foregroundColor(.white)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                    .cornerRadius(20)
            }
        }
        .onAppear {
            videoStore.videoPlayer(resource: "\(musicTitle).\(partIndex)", isMuted: false, repeatVideo: true)
            videoStore.play()
        }
        .onDisappear {
            videoStore.pause()
        }
    }
}
