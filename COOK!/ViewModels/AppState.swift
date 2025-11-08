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
    
    @Published var groceryList: [Ingredient] = []
    @Published var ingredients: [Ingredient] = []
    @Published var recipes: [Recipe] = []
    
    init() {
        self.selectedTab = .home
        self.backgroundColor = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
        
        setMockData()
    }
    
    func setMockData() {
        var milk: Ingredient = Ingredient(name: "Milk", quantity: 1)
        var eggs: Ingredient = Ingredient(name: "Eggs", quantity: 2)
        var cheese: Ingredient = Ingredient(name: "Cheese", quantity: 3)
        
        groceryList = [milk, eggs, cheese]
    }
    
    func addToGroceryList(_ ingredient: Ingredient) {
        groceryList.append(ingredient)
    }
    
    func addToGroceryList(name: String, quantity: Int) {
        groceryList.append(Ingredient(name: name, quantity: quantity))
    }
}
