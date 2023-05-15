//
//  MotionSplitView.swift
//  MC2
//
//  Created by nyla on 2023/05/12.
//

import SwiftUI

struct MotionSplitView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("한 동작씩 쪼개보기")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                
                CenterMotionView()
                    .frame(height: UIScreen.main.bounds.height * 0.64)
                //.padding(.horizontal, 20)
                
                Spacer()
                
                BottomMotionView()
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
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.cyan)
        })
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Step 2")
                        .foregroundColor(.pointColor)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct CenterMotionView: View {
    @EnvironmentObject var danceStore: DanceStore
    
    var body: some View {
        TabView {
            ForEach(0..<danceStore.selectedDancePart!.dancePauseImage.count) { index in
                Image(uiImage: danceStore.selectedDancePart!.dancePauseImage[index])
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20.0)
                    .tag(index)
                    .onAppear {
                        danceStore.splitIndex = index
                        print(danceStore.splitIndex)
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
    
    var body: some View {
        HStack {
            ForEach(0..<danceStore.selectedDancePart!.dancePauseImage.count) { index in
                Image(uiImage: danceStore.selectedDancePart!.dancePauseImage[index])
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .frame(width: UIScreen.main.bounds.width / 11)
                    .overlay {
                        Rectangle()
                            .fill(Color.black)
                            .opacity(danceStore.splitIndex == index ? 0 : 0.4)
                    }
            }
        }
    }
}
