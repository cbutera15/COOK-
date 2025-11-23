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
        case loading
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
    
    //vars for handling async operations
    @Published var isLoading = false
    @Published var signedIn = false
    @Published var operationFailed = false
    @Published var showError = false
    @Published var error = ""
    
    @Published var selectedTab: MenuTab
    @Published var lastSelectedTab: MenuTab
    @Published var backgroundColor: Color
    
    @Published var searchName:String = ""
    @Published var searchFeild: String = ""
    @Published var searchLower: Int = 0
    @Published var searchUpper: Int = 10
    
    @Published var groceryList: [Ingredient] = []
    @Published var selectedGroceryItems: [Ingredient] = []
    @Published var ingredients: [Ingredient] = []
    @Published var savedRecipes: [Recipe] = []
    @Published var favoriteRecipes: [Recipe] = []
    @Published var schedule: [Day] = []
    
    init() {
        fstore = Reader()
        
        self.selectedTab = .signIn
        self.lastSelectedTab = .loading
        self.backgroundColor = Color(hue: 0.7444, saturation: 0.05, brightness: 0.93)
        
        setMockData()
    }
    
    func changeLowerSearch(_ n:Int){
        searchLower += n
        if searchLower >= searchUpper{
            searchLower = searchUpper - 1
        }
        if searchLower < 0 {
            searchLower = 0
        }
    }
    
    func changeUpperSearch(_ n:Int){
        searchUpper += n
        if searchUpper <= searchLower{
            searchUpper = searchLower + 1
        }
        if searchUpper > 50{
            searchUpper = 50
        }
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
        
        var chickenAndRice = Recipe(name: "Chicken and Rice", description: "Classic, easy chicken and rice.", imagePath: Image(.chickenAndRice), ingredients: [chicken, rice], instructions: "Cook Chicken \n Cook Rice \n Combine")
        var pastaSalad = Recipe(name: "Pasta salad", description: "Cold, refreshing pasta salad.", imagePath: Image(.pastaSalad), ingredients: [pasta, cheese])
        var spaghettiWithMeatballs = Recipe(name: "Spaghetti with meatballs", description: "Beef Meatballs with red sauce and spaghetti", imagePath: Image(.spaghettiAndMeatballs), ingredients: [pasta, redSauce, meatballs, cheese])
        var grilledSalmon = Recipe(name: "Grilled salmon", description: "Tender grilled salmon fillet", imagePath: Image(.grilledSalmon), ingredients: [salmon])
        var eggsAndToast = Recipe(name: "Eggs and toast", description: "Classic simple breakfast", imagePath: Image(.eggsAndToast), ingredients: [eggs, toast])
        
        groceryList = [chicken, pasta]
        ingredients = [milk, eggs, cheese, toast]
        savedRecipes = [chickenAndRice, pastaSalad, spaghettiWithMeatballs, grilledSalmon, eggsAndToast]
        schedule = []
    }
    
    func signOut(){
        if fstore.user.id == "N/A"{
            return
        }
        
        fstore.logOut()
        signedIn = false
        nvEmail = ""
        nvPassword = ""
        
        selectedTab = .signIn
    }
    
    func signIn(email: String, password: String)async{
        if fstore.user.id != "N/A"{
            signedIn = true
            loadUserData()
        }
        isLoading = true
        operationFailed = false
        do{
            let result = try await fstore.signIn(email: email, password: password)
            if result{
                signedIn = true
                loadUserData()
            }else{
                operationFailed = true
            }
        }catch{
            self.error = error.localizedDescription
            showError = true
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func createUser(email: String, password: String) async{
        isLoading = true
        operationFailed = false
        do{
            let result = try await fstore.createAccount(email: email, password: password)
            if result{
                signedIn = true
            }else{
                operationFailed = true
            }
        }catch{
            self.error = error.localizedDescription
            showError = true
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func loadUserData(){
        if fstore.user.id == "N/A"{
            return
        }
        favoriteRecipes = fstore.user.favoriteRecipes
        savedRecipes = fstore.user.customRecipes
        schedule = fstore.user.calendar
        ingredients = fstore.user.pantry
        groceryList = fstore.user.list
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
        for ing in selectedGroceryItems{
            fstore.rmList(ing)
        }
        selectedGroceryItems = []
    }
    
    func clearGroceryList() {
        groceryList.removeAll()
        fstore.clearList()
    }
    
    func addToGroceryList(_ items: [Ingredient]) {
        groceryList.append(contentsOf: items)
        for ing in items{
            fstore.addToList(ing)
        }
        
    }
    
    func addToGroceryList(name: String, quantity: Int, unit: Ingredient.Unit) {
        let item = Ingredient(name: name, quantity: quantity, unit: unit)
        groceryList.append(item)
        fstore.addToList(item)
    }
        
    func addToGroceryList(name: String, quantity: Int) {
        let item = Ingredient(name: name, quantity: quantity, unit: .none)
        groceryList.append(item)
        fstore.addToList(item)
    }
    
    func saveGroceryList(){
        fstore.saveList(groceryList)
    }
    
    func addToPantry(_ items: [Ingredient]) {
        ingredients.append(contentsOf: items)
        for ing in items{
            fstore.addToPantry(ing)
        }
    }
    
    func addSavedRecipe(_ recipe: Recipe) {
        savedRecipes.append(recipe)
        fstore.addUserRecipe(recipe)
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
        fstore.saveList(groceryList)
        fstore.savePantry(ingredients)
        fstore.saveCalendar(schedule)
    }
}

