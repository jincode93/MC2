//
//  MotionSplitView.swift
//  MC2
//
//  Created by nyla on 2023/05/12.
//

import SwiftUI

struct MotionSplitView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var danceStore: DanceStore
    @EnvironmentObject var videoStore: VideoStore
    @Environment(\.presentationMode) var presentationMode
    
    @State var music: Music
    @State var dancePart: DancePart
    @State var splitViewCurrentTab: Int = 0
    @State private var isSheetUp: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("\(music.musicTitle) - Part\(dancePart.partIndex)")
                    .foregroundColor(.stringColor)
                
                CenterMotionView(splitViewCurrentTab: $splitViewCurrentTab, dancePart: dancePart)
                    .frame(height: UIScreen.main.bounds.height * 0.64)
                
                Spacer()
                
                BottomMotionView(splitViewCurrentTab: $splitViewCurrentTab, dancePart: dancePart)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    viewRouter.currentPage = "page5"
                } label: {
                    Text("촬영하기")
                        .modifier(LongButtonModifier())
                }
            }
        }
        .onAppear {
            videoStore.videoPlayer(resource: "\(music.musicTitle).\(dancePart.partIndex)", isMuted: false, repeatVideo: true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.cyan)
                }),
            trailing:
                Button(action: {
                    isSheetUp.toggle()
                }, label: {
                    VStack {
                        Image(systemName: "play.circle")
                            .font(.title3)
                            .foregroundColor(.pointColor)
                    }
                })
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("한 동작씩 쪼개보기")
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .sheet(isPresented: $isSheetUp) {
            VideoViewSheet(music: music, dancePart: dancePart)
        }
    }
}

struct CenterMotionView: View {
    @EnvironmentObject var danceStore: DanceStore
    @Binding var splitViewCurrentTab: Int
    @State var dancePart: DancePart
    
    var body: some View {
        TabView(selection: $splitViewCurrentTab) {
            ForEach(dancePart.dancePauseImage.indices, id: \.self) { index in
                Image(uiImage: dancePart.dancePauseImage[splitViewCurrentTab])
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20.0)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
}

struct BottomMotionView: View {
    @EnvironmentObject var danceStore: DanceStore
    @State var opacity: Double = 0.0
    @Binding var splitViewCurrentTab: Int
    @State var dancePart: DancePart
    
    var body: some View {
        HStack {
            ForEach(dancePart.dancePauseImage.indices, id: \.self) { index in
                Image(uiImage: dancePart.dancePauseImage[index])
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .frame(width: UIScreen.main.bounds.width / 11)
                    .overlay {
                        Rectangle()
                            .fill(Color.black)
                            .opacity(index == splitViewCurrentTab ? 0 : 0.4)
                    }
            }
        }
    }
}
