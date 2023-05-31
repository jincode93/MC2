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
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentTab: Int = 0
    
    let music: Music
    @State var dancePart: DancePart = DancePart(id: "", partIndex: 0, partMusic: "", dancePauseImage: [], danceFrameImage: [], danceVideo: "")
    
    
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
                                    
                                    PartSellectedVideoView(musicTitle: music.musicTitle, partIndex: index + 1)
                                }
                                
                                Rectangle()
                                    .fill(Color.black)
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
                
                NavigationLink {
                    MotionSplitView(music: music, dancePart: dancePart)
                        .environmentObject(danceStore)
                } label: {
                    Text("선택")
                        .modifier(LongButtonModifier())
                }
            } // VStack
        } // ZStack
        .onAppear {
            if !music.dancePartArr.isEmpty {
                dancePart = music.dancePartArr[0]
            }
            DispatchQueue.main.async {
                danceStore.selectedMusic = self.music
            }
        }
        .onChange(of: currentTab, perform: { newValue in
            dancePart = music.dancePartArr[newValue]
            DispatchQueue.main.async {
                danceStore.selectedDancePart = music.dancePartArr[newValue]
            }
        })
        .navigationBarItems(
            leading:
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.stringColor)
                        .bold()
                })
        )
        .navigationTitle(Text("안무 구간 선택"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
