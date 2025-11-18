//
//  Ingredient.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import Foundation

struct Ingredient: Identifiable {
    var name: String
    var quantity: String
    var unit: String
    let id = UUID()
    
    init(name: String, quantity: String, unit: String) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}
