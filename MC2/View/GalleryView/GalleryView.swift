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
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(dataManager.resultArr) { result in
                        AnimatedImageFrameView(images: result.imageArr, duration: 2.5)
                            .frame(width: UIScreen.main.bounds.width * 0.9)
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
            .onAppear {
                dataManager.fetchFinalResults()
            }
        }
    }
}
