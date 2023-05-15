//
//  ContentView.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var danceStore: DanceStore
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var cameraStore: CameraModel
    @EnvironmentObject var musicStore: MusicStore
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            switch viewRouter.currentPage {
            case "page1":
                SplashView()
            case "page2":
                OnboardingView()
            case "page3":
                SignInView()
            case "page4":
                MainView()
            case "page5":
                CameraView(selectedPart: danceStore.selectedDancePart ?? nil)
            case "page6":
                GifView()
            case "page7":
                SendToDBProgressView()
            default:
                Text("Error: Invalid Page")
            }
        }
        .environmentObject(viewRouter)
        .environmentObject(danceStore)
        .environmentObject(userStore)
        .environmentObject(musicStore)
        .environmentObject(cameraStore)
        .onAppear {
            Task {
                await danceStore.musicWillFetchDB()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
