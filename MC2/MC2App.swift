//
//  MC2App.swift
//  MC2
//
//  Created by Jin on 2023/05/06.
//

import SwiftUI
import FirebaseCore
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinalResult")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
    @StateObject var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .environmentObject(danceStore)
                .environmentObject(userStore)
                .environmentObject(cameraStore)
                .environmentObject(musicStore)
                .environmentObject(videoStore)
                .environmentObject(dataManager)
        }
    }
}
