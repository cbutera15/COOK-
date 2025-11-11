//
//  Ingredient.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import Foundation

struct Ingredient: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
    
    mutating func increment() {
        quantity += 1
    }
    
    mutating func decrement() {
        if quantity > 0 {
            quantity -= 1
        }
    }
}
