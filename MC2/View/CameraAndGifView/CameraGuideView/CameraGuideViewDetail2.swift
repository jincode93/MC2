//
//  CameraGuideViewDetail2.swift
//  MC2
//
//  Created by Jin on 2023/05/17.
//

import SwiftUI
import AVKit

struct CameraGuideViewDetail2: View {
    @EnvironmentObject var videoStore: VideoStore
    @EnvironmentObject var cameraStore: CameraModel
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .opacity(0.6)
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        cameraStore.guideViewToggle = false
                        cameraStore.pageControl = true
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.stringColor)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                }
                Spacer()
            }
            
            VStack(spacing: 20) {
                Text("동작 GUIDE")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.top, 20)
                
                ZStack {
                    if let player = videoStore.player {
                        VideoPlayer(player: player)
                            .frame(width: width * 0.516, height: height * 0.43)
                            .padding(.bottom, width * 0.05)
                            .zIndex(1)
                    } else {
                        Text("비디오 로딩을 실패했습니다.🥲")
                            .foregroundColor(.white)
                            .frame(maxWidth: width * 0.7)
                            .cornerRadius(20)
                            .zIndex(1)
                    }
                    
                    Image("CameraScript2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.7)
                }
                
                Text("이전 동작을 유지한 상태에서\n다음 동작을 자연스럽게 연결해 보세요")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.bottom, 30)
        }
        .onAppear {
            videoStore.videoPlayer(resource: "CameraGuide", isMuted: true, repeatVideo: true)
            videoStore.play()
        }
        .onDisappear {
            videoStore.pause()
        }
    }
}
