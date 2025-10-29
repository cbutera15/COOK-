//
//  AppState.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/29/25.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    enum MenuTab {
        case home
        case groceryList
        case ingredients
        case plus
        case recipes
        case schedule
    }
    
    @Published var selectedTab: MenuTab
    @Published var backgroundColor: Color
    
    init() {
        self.selectedTab = .home
        self.backgroundColor = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
    }
}
