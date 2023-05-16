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
    @Environment(\.presentationMode) var presentationMode
    
    @State var currentTab: Int
    @State private var isSheetUp: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("\(danceStore.selectedMusic!.musicTitle)-Part\(currentTab + 1)")
                    .foregroundColor(.stringColor)
                
                CenterMotionView(currentTab: $currentTab)
                    .frame(height: UIScreen.main.bounds.height * 0.64)
                
                Spacer()
                
                BottomMotionView(currentTab: $currentTab)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink {
                    CameraView()
                } label: {
                    Text("촬영하기")
                        .modifier(LongButtonModifier())
                }
            }
        }
        .sheet(isPresented: $isSheetUp) {
            VideoViewSheet(currentTab: $currentTab)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
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
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct CenterMotionView: View {
    @EnvironmentObject var danceStore: DanceStore
    @Binding var currentTab: Int
    
    var body: some View {
        TabView(selection: $currentTab) {
            if let danceImagesArr = danceStore.selectedDancePart?.dancePauseImage {
                ForEach(danceImagesArr.indices, id: \.self) { index in
                    Image(uiImage: danceImagesArr[currentTab])
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20.0)
                        .tag(index)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
}

struct BottomMotionView: View {
    @EnvironmentObject var danceStore: DanceStore
    @State var opacity: Double = 0.0
    @Binding var currentTab: Int
    
    var body: some View {
        HStack {
            if let danceImagesArr = danceStore.selectedDancePart?.dancePauseImage {
                ForEach(danceImagesArr.indices, id: \.self) { index in
                    Image(uiImage: danceImagesArr[index])
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                        .frame(width: UIScreen.main.bounds.width / 11)
                        .overlay {
                            Rectangle()
                                .fill(Color.black)
                                .opacity(index == currentTab ? 0 : 0.4)
                        }
                }
            }
        }
    }
}
