//
//  Ingredient.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import Foundation

struct Ingredient: Identifiable {
    var name: String
    var quantity: Int
    let id = UUID()
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
}
