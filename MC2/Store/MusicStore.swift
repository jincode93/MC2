//
//  musicStore.swift
//  MC2
//
//  Created by Jin on 2023/05/14.
//

import Foundation
import AVFoundation

class MusicStore: ObservableObject {
    var player: AVAudioPlayer!
    
    func playSound(musicTitle: String, musicType: String = ".mp3", loop: Bool) {
        let loopControl: Int = loop ? -1 : 0
        
        let url = Bundle.main.url(forResource: musicTitle, withExtension: musicType)
        
        guard url != nil else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.numberOfLoops = loopControl
            player?.play()
        } catch {
            print("PlaySound Function Error: \(error)")
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}
