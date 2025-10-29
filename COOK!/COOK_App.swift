//
//  COOK_App.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//

import SwiftUI


@main
struct SimpleTabViewApp: App {
    @EnvironmentObject var appState: AppState
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
