//
//  CustomTabButton.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/29/25.
//

import SwiftUI

struct CustomTabButton: View {
    @EnvironmentObject var appState: AppState
    let iconName: String
    let destination: AppState.MenuTab
    let tabColor: Color
    let appColor: Color
    
    var body: some View {
        Button(action: {
            appState.selectedTab = destination
            appState.backgroundColor = appColor
            appState.updateBackend()
        }) {
            Image(systemName: iconName)
                .font(.system(size: 28))  
                .foregroundColor(appState.selectedTab == destination ? tabColor : .gray)
                .padding()
        }
    }
}

#Preview {
    CustomTabButton(iconName: "list.dash", destination: .groceryList, tabColor: .pink, appColor: .white)
        .environmentObject(AppState())
}
