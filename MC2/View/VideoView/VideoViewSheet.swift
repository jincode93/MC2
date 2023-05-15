//
//  VideoViewSheet.swift
//  MC2
//
//  Created by Toughie on 2023/05/16.
//

import SwiftUI
import AVKit

struct VideoViewSheet: View {
    @EnvironmentObject var danceStore: DanceStore
//    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var videoStore: VideoStore
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var currentTab: Int
    @State private var makeVideo: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .zIndex(0)
            
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.trailing)
                            .padding(.trailing)
                    }

                }
                Spacer()
            }
            
            VStack {
                Text("영상으로 익히기")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.top)
                    .padding(.top)
                
                Spacer()
                
                if makeVideo {
                    let player = videoStore.player
                    VideoPlayer(player: player)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                        .cornerRadius(20)
                        .zIndex(3)
                } else {
                    Text("비디오 로딩을 실패했습니다.🥲")
                        .foregroundColor(.white)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                        .cornerRadius(20)
                }
                
//                if let player = videoStore.player {
//                    VideoPlayer(player: player)
//                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
//                        .cornerRadius(20)
//                        .zIndex(3)
//                } else {
//                    Text("비디오 로딩을 실패했습니다.🥲")
//                        .foregroundColor(.white)
//                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
//                        .cornerRadius(20)
//                }
                
                Spacer()
                
//                Button {
//                    withAnimation(.easeInOut) {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                } label: {
//                    Text("닫기")
//                        .modifier(LongButtonModifier())
//                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            DispatchQueue.main.async {
                danceStore.selectedDancePart = danceStore.selectedMusic?.dancePartArr[danceStore.tabIndex]
                videoStore.videoPlayer(resource: "\(danceStore.selectedMusic!.musicTitle).\(currentTab + 1)", isMuted: false, repeatVideo: true)
                videoStore.play()
            }
            makeVideo.toggle()
        }
        .onDisappear {
            videoStore.pause()
        }
    }
}


//struct VideoViewSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoViewSheet()
//    }
//}
