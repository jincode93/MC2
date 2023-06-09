//
//  SplashView.swift
//  MC2
//
//  Created by toughie on 2023/05/06.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack {
            Color.blackColor.ignoresSafeArea()
            
            Image("DdokDdakLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 190)
            LottieView(jsonName: "Lottie", loopMode: .playOnce)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                viewRouter.currentPage = "page2"
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
