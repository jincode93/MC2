//
//  GalleryViewGrid.swift
//  ADA_MC2
//
//  Created by Toughie on 2023/05/09.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(userStore.user!.userMusics) { music in
                        ForEach(music.userDanceParts) { part in
                            AnimatedImageFrameView(images: part.userDanceImages, duration: 2.5)
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                        }
                        
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.stringColor)
            })
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("갤러리")
                            .modifier(TitleModifier())
                    }
                }
            }
        }
    }
}
