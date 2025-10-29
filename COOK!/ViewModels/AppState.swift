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
    
    init() {
        self.selectedTab = .home
    }
    
    func setTab(_ tab: MenuTab) {
        selectedTab = tab
    }
}
