//
//  VideoView.swift
//  MC2
//
//  Created by toughie on 2023/05/12.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @EnvironmentObject var danceStore: DanceStore
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var videoStore: VideoStore
    @Environment(\.presentationMode) var presentationMode
    
    @State var currentTab: Int
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("영상으로 익히기")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                
                Spacer()
                
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
                
                Spacer()
                
                NavigationLink {
                    MotionSplitView()
                } label: {
                    Text("선택")
                        .modifier(LongButtonModifier())
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.stringColor)
                            .bold()
                    }),
                trailing:
                    HStack(spacing: 20) {
                        Button {
                            viewRouter.currentPage = "page4"
                        } label: {
                            Image(systemName: "house")
                                .font(.title3)
                                .foregroundColor(.stringColor)
                                .bold()
                        }
                    }
                    .foregroundColor(Color.stringColor)
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Step 1")
                            .foregroundColor(.pointColor)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            danceStore.selectedDancePart = danceStore.selectedMusic?.dancePartArr[danceStore.tabIndex]
            videoStore.videoPlayer(resource: "\(danceStore.selectedMusic!.musicTitle).\(currentTab + 1)", isMuted: false, repeatVideo: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                videoStore.play()
            }
        }
        .onDisappear {
            videoStore.pause()
        }
//        .onChange(of: danceStore.tabIndex) { newValue in
//            videoStore.pause()
//            videoStore.videoPlayer(resource: "\(danceStore.selectedMusic!.musicTitle).\(danceStore.tabIndex + 1)", isMuted: false, repeatVideo: false)
//            videoStore.play()
//        }
    }
}
