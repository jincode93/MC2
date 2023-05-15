//
//  MC2App.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MC2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewRouter = ViewRouter()
    @StateObject var danceStore = DanceStore()
    @StateObject var userStore = UserStore()
    @StateObject var cameraStore = CameraModel()
    @StateObject var musicStore = MusicStore()
    @StateObject var videoStore = VideoStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .environmentObject(danceStore)
                .environmentObject(userStore)
                .environmentObject(cameraStore)
                .environmentObject(musicStore)
                .environmentObject(videoStore)
        }
    }
}
