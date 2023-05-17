//
//  VideoViewSheet.swift
//  MC2
//
//  Created by Toughie on 2023/05/16.
//

import SwiftUI
import AVKit

struct VideoViewSheet: View {
    @StateObject var videoStore = VideoStore()
    @EnvironmentObject var danceStore: DanceStore
    @Environment(\.dismiss) private var dismiss
    
    @State var music: Music
    @State var dancePart: DancePart
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .zIndex(0)
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.pointColor)
                            .padding(.top)
                            .padding(.trailing)
                            .padding(.trailing)
                    }
                }
                Spacer()
            }
            
            VStack {
                Text("영상으로 익히기")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.top, 40)
                
                Spacer()
                
                VStack {
                    Text("\(music.musicTitle) - Part.\(dancePart.partIndex)")
                        .font(.title3)
                        .foregroundColor(.stringColor)
                }
                
                ZStack {
                    Image("videoFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)
                        .zIndex(1)
                    
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
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            videoStore.videoPlayer(resource: "\(music.musicTitle).\(dancePart.partIndex)", isMuted: false, repeatVideo: true)
            videoStore.play()
        }
        .onDisappear {
            videoStore.pause()
        }
    }
}

