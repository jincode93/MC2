//
//  CameraGuideViewDetail1.swift
//  MC2
//
//  Created by Jin on 2023/05/17.
//

import SwiftUI

struct CameraGuideViewDetail1: View {
    @EnvironmentObject var cameraStore: CameraModel
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .opacity(0.6)
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        cameraStore.guideViewToggle = false
                        cameraStore.pageControl = true
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.stringColor)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                }
                Spacer()
            }
            
            VStack(spacing: 20) {
                Text("촬영 GUIDE")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                
                Image("CameraScript1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.69)
                
                Text("전신이 프레임 안으로 들어올 수 있도록\n기기의 위치를 조정하세요")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 30)
        }
    }
}
