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
        case pantry
        case plus
        case recipes
        case schedule
    }
    
    @Published var selectedTab: MenuTab
    @Published var backgroundColor: Color
    
    @Published var groceryList: [Ingredient] = []
    @Published var selectedGroceryItems: [Ingredient] = []
    @Published var ingredients: [Ingredient] = []
    @Published var recipes: [Recipe] = []
    @Published var favoriteRecipes: [Recipe] = []
    
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
        
        ingredients = [milk, eggs, cheese]
    }
    
    func addToGroceryList(_ item: Ingredient) {
        groceryList.append(item)
    }
    
    func addToGroceryList(name: String, quantity: Int) {
        groceryList.append(Ingredient(name: name, quantity: quantity))
    }
    
    func removeFromGroceryList(_ items: [Ingredient]) {
        groceryList.removeAll { items.contains($0) }
    }
    
    func addToPantry(_ items: [Ingredient]) {
        ingredients.append(contentsOf: items)
    }
    
    func addToFavorites(_ recipe: Recipe) {
        favoriteRecipes.append(recipe)
    }
    
    func removeFromFavorites(_ recipe: Recipe) {
        favoriteRecipes.removeAll { $0.id == recipe.id }
    }
    
    
    
    
    func updateBackend() {
        // placeholder to save data to backend
        // could execute on app close or on every update to AppState
    }
}
