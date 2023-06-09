//
//  PartSellectTabView.swift
//  MC2
//
//  Created by Jin on 2023/05/12.
//

import SwiftUI

struct PartSellectTabView: View {
    @EnvironmentObject var danceStore: DanceStore
    @EnvironmentObject var musicStore: MusicStore
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
                    .padding(.bottom, UIScreen.main.bounds.height * 49 / 80)
                    .padding(.trailing, UIScreen.main.bounds.width / 2)
                    .zIndex(1)
                    
                    TabView(selection: $currentTab) {
                        ForEach(music.dancePartArr.indices, id: \.self) { index in
                            AnimatedImageDanceFrameView(images: music.dancePartArr[currentTab].dancePauseImage, duration: 3, index: currentTab, count: music.dancePartArr.count)
                                .tag(index)
                        }
                    }
                    .onAppear {
                        musicStore.playSound(musicTitle: "\(music.musicTitle).1", loop: true)
                        
                    }
                    .onChange(of: currentTab, perform: { newValue in
                        musicStore.playSound(musicTitle: "\(music.musicTitle).\(newValue + 1)", loop: true)
                        print(currentTab)
                        danceStore.tabIndex = currentTab
                    })
                    
                    .tabViewStyle(PageTabViewStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.7)
                    .cornerRadius(20)
                }
                
                Spacer()
                
                NavigationLink {
                    VideoView(currentTab: currentTab)
                        .environmentObject(danceStore)
                } label: {
                    Text("선택")
                        .modifier(LongButtonModifier())
                }
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
