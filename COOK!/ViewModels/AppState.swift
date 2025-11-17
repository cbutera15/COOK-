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
    @Published var savedRecipes: [Recipe] = []
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
        var toast: Ingredient = Ingredient(name: "Toast", quantity: 2)
        
        var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2)
        var rice: Ingredient = Ingredient(name: "Rice", quantity: 1)
        var pasta: Ingredient = Ingredient(name: "Pasta", quantity: 1)
        var redSauce: Ingredient = Ingredient(name: "Red sauce", quantity: 1)
        var meatballs: Ingredient = Ingredient(name: "Meatballs", quantity: 6)
        var salmon: Ingredient = Ingredient(name: "Salmon", quantity: 1)
        
        var chickenAndRice = Recipe(name: "Chicken and Rice", ingredients: [chicken, rice])
        var pastaSalad = Recipe(name: "Pasta salad", ingredients: [pasta, cheese])
        var spaghettiWithMeatballs = Recipe(name: "Spaghetti with meatballs", ingredients: [pasta, redSauce, meatballs, cheese])
        var grilledSalmon = Recipe(name: "Grilled salmon", ingredients: [salmon])
        var eggsAndToast = Recipe(name: "Eggs and toast", ingredients: [eggs, toast])
        
        groceryList = [chicken, pasta]
        ingredients = [milk, eggs, cheese, toast]
        savedRecipes = [chickenAndRice, pastaSalad, spaghettiWithMeatballs, grilledSalmon, eggsAndToast]
    }
    
    func addToGroceryList(_ items: [Ingredient]) {
        groceryList.append(contentsOf: items)
    }
    
    func addToGroceryList(name: String, quantity: Int, unit: Ingredient.Unit) {
        groceryList.append(Ingredient(name: name, quantity: quantity, unit: unit))
    }
    
    func removeFromGroceryList(_ items: [Ingredient]) {
        groceryList.removeAll { item in
            items.contains(where: { $0.id == item.id })
        }
    }
    
    func addToPantry(_ items: [Ingredient]) {
        ingredients.append(contentsOf: items)
    }
    
    func addSavedRecipe(_ recipe: Recipe) {
        savedRecipes.append(recipe)
    }
    
    func addToFavorites(_ recipe: Recipe) {
        favoriteRecipes.append(recipe)
    }
    
    func removeFromFavorites(_ recipe: Recipe) {
        favoriteRecipes.removeAll { $0.id == recipe.id }
    }
    
    func hasAllIngredients(_ items: [Ingredient]) -> Bool {
        for item in items {
            guard let matching = ingredients.first(where: { $0.name == item.name }) else {
                return false
            }
            if matching.quantity < item.quantity {
                return false
            }
        }
        
        return true
    }
    
    
    
    
    func updateBackend() {
        // placeholder to save data to backend
        // could execute on app close or on every update to AppState
    }
}

