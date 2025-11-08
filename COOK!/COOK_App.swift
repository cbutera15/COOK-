//
//  COOK_App.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//

import SwiftUI
//import FirebaseCore


func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //FirebaseApp.configure()
    return true
}

@main
struct SimpleTabViewApp: App {
    @StateObject private var appState = AppState()
    init() {
            //FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
