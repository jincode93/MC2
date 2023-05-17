//
//  GifView.swift
//  MC2
//
//  Created by Jin on 2023/05/09.
//

import SwiftUI

struct GifView: View {
    @EnvironmentObject var cameraStore: CameraModel
    @EnvironmentObject var danceStore: DanceStore
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var dataManager: DataManager
    @State private var imageArray: [UIImage] = []
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("DDOK-DDAK\n댄스가 완성 되었어요!")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                if !imageArray.isEmpty {
                    AnimatedImageFrameView(images: imageArray, duration: 2.5)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.74)
                        .cornerRadius(20)
                } else {
                    ProgressView()
                }
                
                Spacer()
                
                HStack {
                    Button {
                        showingAlert.toggle()
                    } label: {
                        Text("RETRY")
                            .modifier(SortButtonModifier())
                    }
                    .alert(isPresented: $showingAlert) {
                        let button = Alert.Button.default(Text("다시 촬영하기")) {
                            viewRouter.currentPage = "page5"
                        }
                        return Alert(title: Text("다시 촬영하시겠습니까?"),
                                     message: Text("기존에 촬영한 사진은 삭제됩니다."),
                                     primaryButton: button, secondaryButton: .default(Text("취소")))
                    }
                    
                    Spacer()
                    
                    Button {
                        Task {
                            viewRouter.currentPage = "page7"
                            dataManager.saveFinalResult(id: UUID().uuidString, musicTitle: danceStore.selectedMusic?.musicTitle ?? "", partIndex: danceStore.selectedDancePart?.partIndex ?? 0, imageArr: imageArray)
                        }
                    } label: {
                        Text("GALLERY")
                            .modifier(SortButtonModifier(foregroundColor: .pointColor))
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.vertical, 20)
        }
        .onAppear {
            Task {
                self.imageArray = cameraStore.images
            }
        }
    }
}

struct GifView_Previews: PreviewProvider {
    static var previews: some View {
        GifView()
    }
}
