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
    var imagePath: String
    var ingredients: [Ingredient]
    var instructions: [String]
    
    init(name: String) {
        self.name = name
        self.imagePath = ""
        self.ingredients = []
        self.instructions = []
    }
    
    mutating func setImagePath(_ path: String) {
        imagePath = path
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
