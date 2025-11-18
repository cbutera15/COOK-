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
    private var email: String
    private var calendar: [[String]]//Each row is a time slot moring, evening, and afternoon
    private var customRecipes: [Recipe]
    private var favoriteRecipes: [Recipe]
    
    init(){
        id = "N/A"
        email = ""
        calendar = []
        customRecipes = []
        favoriteRecipes = []
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
    
    //resets all data to what it would be at init
    func rmAll(){
        id = "N/A"
        email = ""
        calendar = []
        customRecipes = []
        favoriteRecipes = []
    }
    
}
