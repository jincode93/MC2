//
//  MainView.swift
//  MC2
//
//  Created by toughie on 2023/05/08.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var danceStore: DanceStore
    @State var isSelected: DanceLevel = .EASY
    private var filteredMusic: [Music] {
        switch isSelected {
        case .ALL:
            return danceStore.music
        case .EASY:
            return danceStore.music.filter { $0.danceLevel == "Easy" }
        case .NORMAL:
            return danceStore.music.filter { $0.danceLevel == "Normal" }
        case .HARD:
            return danceStore.music.filter { $0.danceLevel == "Hard" }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    ZStack(alignment: .bottomLeading) {
                        if userStore.user?.recentMusic == nil {
                            Rectangle()
                                .fill(Color.black.opacity(0.6))
                                .frame(height: UIScreen.main.bounds.height * 0.25)
                                .padding(.horizontal)
                        } else {
                            Image(userStore.user?.recentMusic ?? "")
                                .resizable()
                                .scaledToFill()
                                .opacity(0.2)
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
                                .cornerRadius(15)
                                .padding(.horizontal)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("뚝딱님")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                
                                Text("DDOK-DDAK")
                                    .font(.title3)
                                    .foregroundColor(.pointColor)
                                    .fontWeight(.bold)
                                
                                Text("할")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                            .padding(.bottom, 3)
                            
                            Text("노래를 선택하세요")
                                .font(.title3)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding(20)
                    }
                    
                    VStack {
                        GeometryReader { proxy in
                            segmentControl(isSelected: $isSelected)
                                .frame(width: proxy.size.width, height: 100)
                                .offset(y: max(-(proxy.frame(in: .global).minY - 90), 0))

                        }
                        .padding(.bottom,50)
                        .zIndex(3)
                        
                        ForEach(filteredMusic) { music in
                            NavigationLink {
                                PartSellectVideoTabView(music: music)
                                    .environmentObject(danceStore)
                            } label: {
                                MainViewCell(music: music)
                            }
                        }
                    }
                }
                .padding(.horizontal, 5)
            } // ScrollView
            .background(Color.black)
            // .ignoresSafeArea(edges: .bottom)
            // .navigationBarHidden(true)
            .navigationBarItems(
                leading:
                    Image("logo")
                    .resizable()
                    .frame(width: 40),
                
                trailing:
                    HStack(spacing: 20) {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .modifier(NavItemModifier())
                        }
                        
                        NavigationLink {
                            GalleryView()
                        } label: {
                            Image(systemName: "photo.stack.fill")
                                .modifier(NavItemModifier())
                        }
                    }
                    .foregroundColor(Color.stringColor)
            )
            .toolbarBackground(
                Color.black, for: .navigationBar
            )
            // .modifier(NavigationBarModifier(backgroundColor: .black))
        } // NavigationView
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
