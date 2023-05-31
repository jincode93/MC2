//
//  GalleryGifView.swift
//  MC2
//
//  Created by Jin on 2023/05/18.
//

import SwiftUI

struct GalleryGifView: View {
    @EnvironmentObject var musicStore: MusicStore
    @State var result: Result
    @State var duration: Double
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("\(result.musicTitle) - Part \(result.partIndex)")
                .foregroundColor(.stringColor)
            
            Spacer()
            
            GalleryFrameView(images: result.imageArr, duration: $duration)
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.7)
                .cornerRadius(20)
            
            Spacer()
        }
        .onAppear {
            musicStore.playSound(musicTitle: "\(result.musicTitle).\(result.partIndex == 0 ? 1 : result.partIndex)", loop: true)
        }
        .onDisappear {
            musicStore.stopSound()
        }
        .padding(.top, 5)
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
        .navigationTitle(Text("갤러리"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
