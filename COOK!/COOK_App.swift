//
//  COOK_App.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//

import SwiftUI
//import FirebaseCore

// Import the SDK
//import ScanbotBarcodeScannerSDK


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
            //Scanbot.setLicense("<YOUR_LICENSE_KEY_HERE>")
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
