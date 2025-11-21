//
//  AppState.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/29/25.
//

import SwiftUI
import Combine

// Extending date to access day of week # (1, sunday -> 7, saturday)
extension Date {
    func getWeekdayNumber() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func withTime(hour: Int, minute: Int = 0, second: Int = 0) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = hour
        components.minute = minute
        components.second = second
        return calendar.date(from: components) ?? self
    }
}

class AppState: ObservableObject {
    enum MenuTab {
        case signIn
        case home
        case groceryList
        case pantry
        case plus
        case recipes
        case schedule
    }
    
    @Published var fstore: Reader
    @Published var nvEmail: String = ""//not verified(nv) email address, is cleared on signin
    @Published var nvPassword: String = ""//not verified(nv) user password, is cleared on signin
    @Published var signInStatus: Bool = false
    
    @Published var selectedTab: MenuTab
    @Published var backgroundColor: Color
    
    @Published var groceryList: [Ingredient] = []
    @Published var selectedGroceryItems: [Ingredient] = []
    @Published var ingredients: [Ingredient] = []
    @Published var savedRecipes: [Recipe] = []
    @Published var favoriteRecipes: [Recipe] = []
    @Published var schedule: [Day] = []
    
    init() {
        fstore = Reader()
        
        self.selectedTab = .signIn
        self.backgroundColor = Color(hue: 0.7444, saturation: 0.05, brightness: 0.93)
        
        setMockData()
    }
    
    func setMockData() {
        var milk: Ingredient = Ingredient(name: "Milk", quantity: 1, unit: .cup)
        var eggs: Ingredient = Ingredient(name: "Eggs", quantity: 2, unit: .none)
        var cheese: Ingredient = Ingredient(name: "Cheese", quantity: 3, unit: .tablespoon)
        var toast: Ingredient = Ingredient(name: "Toast", quantity: 2, unit: .none)
        
        var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2, unit: .pound)
        var rice: Ingredient = Ingredient(name: "Rice", quantity: 1, unit: .cup)
        var pasta: Ingredient = Ingredient(name: "Pasta", quantity: 1, unit: .pound)
        var redSauce: Ingredient = Ingredient(name: "Red sauce", quantity: 1, unit: .none)
        var meatballs: Ingredient = Ingredient(name: "Meatballs", quantity: 6, unit: .none)
        var salmon: Ingredient = Ingredient(name: "Salmon", quantity: 1, unit: .pound)
        
        var chickenAndRice = Recipe(name: "Chicken and Rice", description: "Placeholder", ingredients: [chicken, rice], instructions: "Placeholder \n Placeholder1")
        var pastaSalad = Recipe(name: "Pasta salad", ingredients: [pasta, cheese])
        var spaghettiWithMeatballs = Recipe(name: "Spaghetti with meatballs", ingredients: [pasta, redSauce, meatballs, cheese])
        var grilledSalmon = Recipe(name: "Grilled salmon", ingredients: [salmon])
        var eggsAndToast = Recipe(name: "Eggs and toast", ingredients: [eggs, toast])
        
        groceryList = [chicken, pasta]
        ingredients = [milk, eggs, cheese, toast]
        savedRecipes = [chickenAndRice, pastaSalad, spaghettiWithMeatballs, grilledSalmon, eggsAndToast]
        schedule = [
            Day(id: 0, name: "Monday", meals: [chickenAndRice, pastaSalad]),
            Day(id: 1, name: "Tuesday", meals: []),
            Day(id: 2, name: "Wednesday", meals: []),
            Day(id: 3, name: "Thursday", meals: []),
            Day(id: 4, name: "Friday", meals: []),
            Day(id: 5, name: "Saturday", meals: []),
            Day(id: 6, name: "Sunday", meals: [])
        ]
    }
    
    func dbConnectDemo(){
        Task{
            try await fstore.signIn(email: "bquacken@uvm.edu", password: "123abc")
            favoriteRecipes = fstore.user.favoriteRecipes
        }
    }
    
    // grocery list functions
    func addGroceryListToPantry() {
        // Only add items from groceryList that are not exact duplicates
        let newItems = groceryList.filter { item in
            !ingredients.contains(where: { existing in
                existing.name == item.name && existing.quantity == item.quantity && existing.unit == item.unit
            })
        }
        ingredients.append(contentsOf: newItems)
    }
    
    func clearSelectedFromGroceryList() {
        groceryList.removeAll { item in
            selectedGroceryItems.contains(where: { $0.id == item.id })
        }
        selectedGroceryItems = []
    }
    
    func clearGroceryList() {
        groceryList.removeAll()
    }
    
    func addToGroceryList(_ items: [Ingredient]) {
        groceryList.append(contentsOf: items)
    }
    
    
    func addToGroceryList(name: String, quantity: Int, unit: Ingredient.Unit) {
        groceryList.append(Ingredient(name: name, quantity: quantity, unit: unit))
    }
        
    func addToGroceryList(name: String, quantity: Int) {
        groceryList.append(Ingredient(name: name, quantity: quantity, unit: .none))
    }
    
    func addToPantry(_ items: [Ingredient]) {
        ingredients.append(contentsOf: items)
    }
    
    func addSavedRecipe(_ recipe: Recipe) {
        savedRecipes.append(recipe)
    }
    
    func addToFavorites(_ recipe: Recipe) {
        favoriteRecipes.append(recipe)
        fstore.addFav(recipe)
    }
    
    func removeFromFavorites(_ recipe: Recipe) {
        favoriteRecipes.removeAll { $0.id == recipe.id }
        fstore.rmFav(recipe.id)
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

    func deleteMealFromSchedule(_ day: Day, _ meal: Recipe) {
        if let dayIndex = schedule.firstIndex(where: { $0.id == day.id }) {
            if let mealIndex = schedule[dayIndex].meals.firstIndex(where: { $0.id == meal.id }) {
                schedule[dayIndex].meals.remove(at: mealIndex)
            }
        }
    }
    
    
    
    
    func updateBackend() {
        // placeholder to save data to backend
        // could execute on app close or on every update to AppState
    }
}

