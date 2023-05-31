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
            GridItem(.flexible(), spacing: 10, alignment: nil),
            GridItem(.flexible(), spacing: 10, alignment: nil)
        ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            Text("갤러리")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                viewRouter.currentPage = "page4"
                            } label: {
                                Image(systemName: "house")
                                    .font(.title2)
                                    .foregroundColor(.stringColor)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .padding(.top, 10)
                    
                    ScrollView {
                        LazyVGrid(columns: columns,
                                  alignment: .center,
                                  spacing: 0) {
                            ForEach(dataManager.resultArr.reversed()) { result in
                                NavigationLink {
                                    GalleryGifView(result: result, duration: 2.5)
                                } label: {
                                    Image(uiImage: result.imageArr.first ?? UIImage())
                                        .resizable()
                                        .scaledToFill()
                                        .rotationEffect(Angle(degrees: 90))
                                        .frame(width: UIScreen.main.bounds.width * 0.47, height: UIScreen.main.bounds.height * 0.3)
                                        .cornerRadius(20)
                                        .padding(.top, 15)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 10)
                .onAppear {
                    if dataManager.isSaveCheck == true {
                        dataManager.fetchFinalResults()
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}
