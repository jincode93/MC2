//
//  VideoStore.swift
//  MC2
//
//  Created by Jin on 2023/05/15.
//

import Foundation
import AVKit

class VideoStore: ObservableObject {
    @Published var player: AVPlayer?
    
    init() {
        if let url = Bundle.main.url(forResource: "CameraGuide", withExtension: "mov") {
            player = AVPlayer(url: url)
            player?.isMuted = true
            
            let duration = CMTimeGetSeconds(player!.currentItem!.asset.duration)
            let time = CMTimeMake(value: Int64(duration), timescale: 1)
            
            player?.addBoundaryTimeObserver(forTimes: [NSValue(time: time)], queue: .main) { [weak self] in
                self?.player?.seek(to: .zero)
                self?.player?.play()
            }
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
