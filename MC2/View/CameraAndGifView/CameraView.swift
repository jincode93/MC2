//
//  CameraView.swift
//  MC2
//
//  Created by Jin on 2023/05/08.
//

import SwiftUI
import Combine
import AVFoundation

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: CameraModel
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var danceStore: DanceStore
    @EnvironmentObject var cameraStore: CameraModel
    @State var selectedPart: DancePart?
    @State var danceFrame: UIImage = UIImage()
    @State var timer: Double = 5.0
    @State var tabSelect: Int = 1
    @State var isbuttonOpacity: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    ZStack {
                        CameraGuideView(tabSelect: tabSelect)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.76)
                            .zIndex(2)
                            .opacity(cameraStore.guideViewToggle ? 1 : 0)
                            .cornerRadius(20)
                        
                        VStack {
                            CameraProgressBar()
                                .padding(.top, 17)
                                .frame(width: UIScreen.main.bounds.width)
                                .opacity(cameraStore.guideViewToggle ? 0 : 1)
                            
                            Spacer()
                        }
                        .zIndex(1)
                        
                        CameraPreview(session: model.session)
                            .frame(height: UIScreen.main.bounds.height * 65 / 80)
                            .onAppear {
                                model.configure()
                            }
                            .alert(isPresented: $model.showAlertError, content: {
                                Alert(title: Text(model.alertError.title), message: Text(model.alertError.message), dismissButton: .default(Text(model.alertError.primaryButtonTitle), action: {
                                    model.alertError.primaryAction?()
                                }))
                            })
                            .animation(.easeInOut, value: model.session)
                            .environmentObject(danceStore)
                            .environmentObject(cameraStore)
                        
                        Image(uiImage: danceFrame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width)
                            .opacity(cameraStore.guideViewToggle ? 0 : 1)
                            .zIndex(2)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                
                                Text(model.counter)
                                    .font(.system(size: 100))
                                    .foregroundColor(.white)
                                    .animation(.easeInOut)
                                    .opacity(model.textOpacity)
                                    .padding(.trailing, 30)
                            }
                        }
                        
                        VStack {
                            Spacer()
                            Image("autoButton")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                                
                            Button {
                                isbuttonOpacity = true
                                model.startPhotoCapture(timer: self.timer)
                                
                                for i in 1...7 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + timer * Double(i)) {
                                        danceFrame = danceStore.selectedDancePart?.danceFrameImage[i] ?? UIImage()
                                        print("Frame Change")
                                    }
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + (timer * 8.0 + 4.3)) {
                                    self.viewRouter.currentPage = "page6"
                                    cameraStore.progressCheck = 0
                                    cameraStore.textOpacity = 0.0
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 60)
                                        .foregroundColor(.white)
                                    
                                    Circle()
                                        .strokeBorder(.white, lineWidth: 3)
                                        .frame(width: 70)
                                }
                            }
                        }
                        .frame(height: 150)
                        .offset(y: UIScreen.main.bounds.height * 17 / 60)
                        .opacity(cameraStore.guideViewToggle ? 0 : 1)
                        .opacity(isbuttonOpacity ? 0 : 1)
                    }
                }
            }
            .onAppear {
                danceFrame = danceStore.selectedDancePart?.danceFrameImage[0] ?? UIImage()
            }
            .onDisappear {
                cameraStore.guideViewToggle = true
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
                    HStack(spacing: 20) {
                        Button {
                            cameraStore.guideViewToggle.toggle()
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .font(.title3)
                                .foregroundColor(.stringColor)
                                .bold()
                                .opacity(isbuttonOpacity ? 0 : 1)
                        }
                    }
                    .foregroundColor(Color.stringColor)
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("동작을 따라해보세요")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
