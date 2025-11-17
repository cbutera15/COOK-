//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Upcoming Meals")
            Spacer()
            Text("Favorite Meals")
            Spacer()
        }
        .padding(.horizontal)
        .background(appState.backgroundColor)
    }
}


#Preview {
    HomeView().environmentObject(AppState())
}
