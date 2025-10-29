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
    var morning: [Recipe]
    var afternoon: [Recipe]
    var evening: [Recipe]
    var snacks: [Recipe]
    
    mutating func addRecipe(recipe: Recipe, time: String) {
        switch time {
        case "Morning":
            morning.append(recipe)
        case "Afternoon":
            afternoon.append(recipe)
        case "Evening":
            evening.append(recipe)
        case "Snacks":
            snacks.append(recipe)
        default:
            break
        }
    }
}


