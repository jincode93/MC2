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
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 15, alignment: nil),
            GridItem(.flexible(), spacing: 15, alignment: nil)
        ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns,
                          alignment: .center,
                          spacing: 0) {
                    ForEach(dataManager.resultArr) { result in
                        GalleryFrameView(images: result.imageArr, duration: 2.5)
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.3)
                            .cornerRadius(20)
                            .padding(.top, 15)
                    }
                }
            }
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.stringColor)
            })
            )
            .navigationBarBackButtonHidden(true)
            .navigationTitle(Text("갤러리"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dataManager.fetchFinalResults()
            }
        }
    }
}
