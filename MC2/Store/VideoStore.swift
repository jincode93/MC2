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
    
    func videoPlayer(resource: String, widthExtension: String = "mov", isMuted: Bool, repeatVideo: Bool) {
        if let url = Bundle.main.url(forResource: resource, withExtension: widthExtension) {
            player = AVPlayer(url: url)
            player?.isMuted = isMuted
            
            if repeatVideo == true {
                let duration = CMTimeGetSeconds(player!.currentItem!.asset.duration)
                let time = CMTimeMake(value: Int64(duration), timescale: 1)
                
                player?.addBoundaryTimeObserver(forTimes: [NSValue(time: time)], queue: .main) { [weak self] in
                    self?.player?.seek(to: .zero)
                    self?.player?.play()
                }
            } else {
                self.player?.play()
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
