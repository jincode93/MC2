//
//  CameraGuide.swift
//  MC2
//
//  Created by Jin on 2023/05/14.
//

import SwiftUI

struct CameraGuideView: View {
    @EnvironmentObject var cameraStore: CameraModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .opacity(0.6)
                
                if cameraStore.pageControl == true {
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Text("촬영 GUIDE")
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                        
                        Image("CameraScript1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.8)
                        
                        Text("전신이 프레임 안으로 들어올 수 있도록\n기기의 위치를 조정하세요")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            self.cameraStore.pageControl = false
                        } label: {
                            Text("다음")
                                .font(.title3)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.8, height: UIScreen.main.bounds.height * 0.06)
                                .background(Color.mainColor)
                                .opacity(0.6)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                    }
                } else {
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Text("동작 GUIDE")
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                        
                        Image("CameraScript2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.8)
                        
                        Text("이전 동작을 유지한 상태에서\n다음 동작을 자연스럽게 연결해 보세요")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            cameraStore.guideViewToggle = false
                            cameraStore.pageControl = true
                        } label: {
                            Text("확인")
                                .font(.title3)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.8, height: UIScreen.main.bounds.height * 0.06)
                                .background(Color.mainColor)
                                .opacity(0.6)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}
