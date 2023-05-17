//
//  PartSellectedVideoView.swift
//  MC2
//
//  Created by Jin on 2023/05/17.
//

import SwiftUI
import AVKit

struct PartSellectedVideoView: View {
    @State var player: AVPlayer?
    var musicTitle: String
    var partIndex: Int
    
    var body: some View {
        ZStack {
            if let player = player {
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
            videoPlayer(resource: "\(musicTitle).\(partIndex)")
            play()
        }
        .onDisappear {
            pause()
        }
    }
    
    func videoPlayer(resource: String, widthExtension: String = "mov") {
        if let url = Bundle.main.url(forResource: resource, withExtension: widthExtension) {
            player = AVPlayer(url: url)
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
