//
//  Recipe.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/24/25.
//

import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var imagePath: String
    var ingredients: [Ingredient]
    var instructions: [String]
    
    init() {
        self.name = ""
        self.description = ""
        self.imagePath = ""
        self.ingredients = []
        self.instructions = []
    }
    
    init(name: String) {
        self.name = name
        self.description = ""
        self.imagePath = ""
        self.ingredients = []
        self.instructions = []
    }
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.description = ""
        self.imagePath = ""
        self.ingredients = ingredients
        self.instructions = []
    }
    
    init(name: String, description: String, imagePath: String, ingredients: [Ingredient], instructions: [String]) {
        self.name = name
        self.description = description
        self.imagePath = imagePath
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    mutating func setName(_ name: String) {
        self.name = name
    }
    
    mutating func setDescription(_ description: String) {
        self.description = description
    }
    
    mutating func setImagePath(_ path: String) {
        imagePath = path
    }
    
    mutating func setIngredients(_ ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
    
    mutating func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    mutating func addIngredient(_ name: String, _ quantity: Int) {
        ingredients.append(Ingredient(name: name, quantity: quantity))
    }
    
    mutating func addInstruction(_ instruction: String) {
        instructions.append(instruction)
    }
    
    mutating func removeIngredient(at index: Int) {
        ingredients.remove(at: index)
    }
    
    mutating func removeInstruction(at index: Int) {
        instructions.remove(at: index)
    }
}
