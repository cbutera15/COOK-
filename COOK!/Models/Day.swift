//
//  Day.swift
//  COOK!
//
//  Created by Colin Butera on 10/29/25.
//

import Foundation

struct Day: Identifiable {
    var id: Int
    var name: String
    var meals: [Recipe]
    
    init(id: Int, name: String, meals: [Recipe]) {
        self.id = id
        self.name = name
        self.meals = meals
    }
    
    mutating func addRecipe(recipe: Recipe) {
        meals.append(recipe)
    }
}


