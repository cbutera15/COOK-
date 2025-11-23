//
//  User.swift
//  test
//
//  Created by Benjamin Quackenbush on 11/6/25.
//
import SwiftUI
import Combine

class User: AnyObject{
    @Published private(set) var id: String
    @Published private(set) var email: String
    @Published private(set) var customRecipes: [Recipe]
    @Published private(set) var favoriteRecipes: [Recipe]
    @Published private(set) var calendar: [Day]
    @Published private(set) var list: [Ingredient]
    @Published private(set) var pantry: [Ingredient]
    
    init(){
        id = "N/A"
        email = ""
        customRecipes = []
        favoriteRecipes = []
        calendar = [
            Day(id: 0, name: "Monday", meals: []),
            Day(id: 1, name: "Tuesday", meals: []),
            Day(id: 2, name: "Wednesday", meals: []),
            Day(id: 3, name: "Thursday", meals: []),
            Day(id: 4, name: "Friday", meals: []),
            Day(id: 5, name: "Saturday", meals: []),
            Day(id: 6, name: "Sunday", meals: [])
        ]
        list = []
        pantry = []
    }
    
    //DO NOT CALL outside signin and createUa
    func setId(_ id: String){
        if self.id == "N/A"{
            self.id = id
        }
        return 
    }
    
    func setEmail(_ email: String){
        self.email = email
    }
    
    func addFav(_ recipe:Recipe){
        favoriteRecipes.append(recipe)
    }
    
    func rmFav(_ id:String){
        favoriteRecipes.removeAll(where:{$0.id == id})
    }
    
    func rmCustom(_ id:String){
        customRecipes.removeAll(where:{$0.id == id})
    }
    
    func addCustom(_ recipe:Recipe){
        customRecipes.append(recipe)
    }
    
    func addToList(_ ingredient: Ingredient){
        list.append(ingredient)
    }
    
    func addToPantry(_ ingredient: Ingredient){
        pantry.append(ingredient)
    }
    
    func setCalList(id: Int, list: [Recipe]){
        for recipe in list{
            calendar[id].addRecipe(recipe)
        }
    }
    
    //resets all data to what it would be at init
    func rmAll(){
        id = "N/A"
        email = ""
        customRecipes = []
        favoriteRecipes = []
        calendar = [
            Day(id: 0, name: "Monday", meals: []),
            Day(id: 1, name: "Tuesday", meals: []),
            Day(id: 2, name: "Wednesday", meals: []),
            Day(id: 3, name: "Thursday", meals: []),
            Day(id: 4, name: "Friday", meals: []),
            Day(id: 5, name: "Saturday", meals: []),
            Day(id: 6, name: "Sunday", meals: [])
        ]
        list = []
        pantry = []
    }
    
}
