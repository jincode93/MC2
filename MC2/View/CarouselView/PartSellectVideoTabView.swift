//
//  PartSellectVideoTabView.swift
//  MC2
//
//  Created by Jin on 2023/05/16.
//

import SwiftUI
import AVKit

struct PartSellectVideoTabView: View {
    @EnvironmentObject var danceStore: DanceStore
    @EnvironmentObject var musicStore: MusicStore
    @EnvironmentObject var videoStore: VideoStore
    @Environment(\.presentationMode) var presentationMode
    
    @State private var currentTab: Int = 0
    
    var music: Music
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("\(music.musicTitle) - \(music.singer)")
                    .font(.callout)
                    .foregroundColor(.stringColor)
                    .padding(.bottom, 3)
                
                ZStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.mainColor)
                                .frame(width: 110, height: 36)
                                .zIndex(0)
                            
                            HStack(alignment: .center) {
                                Circle()
                                    .fill(Color.pointColor)
                                    .frame(width: 8)
                                
                                Text("Part \(currentTab + 1)/\(music.dancePartArr.count)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .zIndex(1)
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 46 / 80)
                    .padding(.trailing, UIScreen.main.bounds.width / 2)
                    .zIndex(1)
                    
                    TabView(selection: $currentTab) {
                        ForEach(music.dancePartArr.indices, id: \.self) { index in
                            VStack {
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
                                
                                Rectangle()
                                    .frame(height: 40)
                            }
                            .tag(index)
                            .padding(.top, 20)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .cornerRadius(20)
                }
                
                Spacer()
                
                Button {
                    danceStore.selectedDancePart = danceStore.selectedMusic?.dancePartArr[currentTab]
                    print(danceStore.selectedDancePart?.partIndex)
                } label: {
                    NavigationLink {
                        MotionSplitView(currentTab: currentTab)
                    } label: {
                        Text("선택")
                            .modifier(LongButtonModifier())
                    }
                }
            }
            .onAppear {
                videoStore.videoPlayer(resource: "\(music.musicTitle).\(currentTab + 1)", isMuted: false, repeatVideo: true)
                videoStore.play()
            }
            .onChange(of: currentTab, perform: { newValue in
                videoStore.pause()
                videoStore.videoPlayer(resource: "\(music.musicTitle).\(currentTab + 1)", isMuted: false, repeatVideo: true)
                videoStore.play()
            })
            .onDisappear {
                videoStore.pause()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.stringColor)
                    .bold()
            })
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("안무 구간 선택")
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
        }
        .onAppear {
            danceStore.selectedMusic = self.music
        }
        .onDisappear {
            musicStore.stopSound()
        }
    }
}
