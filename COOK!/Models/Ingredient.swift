//
//  Ingredient.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import Foundation

struct Ingredient: Identifiable {
    enum Unit: String, CaseIterable, Codable {
        case none
        case teaspoon
        case tablespoon
        case ounce
        case pound
        case milliliter
        case liter
        case kilogram
        case gram
        case gallon
        case cup
        
        var name: (singular: String, plural: String, name: String) {
            switch self {
            case .none: return ("", "", "None")
            case .teaspoon: return ("tsp", "tsp", "Teaspoons")
            case .tablespoon: return ("tbsp", "tbsp", "Tablespoons")
            case .ounce: return ("oz", "oz", "Ounces")
            case .pound: return ("lb", "lbs", "Pounds")
            case .milliliter: return ("ml", "ml", "Milliliters")
            case .liter: return ("l", "l", "Liters")
            case .kilogram: return ("kg", "kgs", "Kilograms")
            case .gram: return ("g", "g", "Grams")
            case .gallon: return ("gallon", "gallons", "Gallons")
            case .cup: return ("cup", "cups", "Cups")
            }
        }
        
        static var allSorted: [Unit] {
            let others = Unit.allCases.filter { $0 != Unit.none }
                .sorted { $0.name.name < $1.name.name }
            return [Unit.none] + others
        }
        
        func display(for quantity: Double) -> String {
            switch self {
            case .none:
                return ""
            default:
                return quantity == 1 ? name.singular.capitalized : name.plural.capitalized
            }
        }
    }
    
    let id = UUID()
    var name: String
    var quantity: Int
    var unit: Unit
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
        self.unit = .none
    }
    
    init(name: String, quantity: Int, unit: Unit) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
    
    mutating func setUnit(_ unit: Unit) {
        self.unit = unit
    }
    
    mutating func increment() {
        quantity += 1
    }
    
    mutating func decrement() {
        if quantity > 1 {
            quantity -= 1
        }
    }
    
    func displayQuantity() -> String {
        return "\(quantity) \(unit.display(for: Double(quantity)))"
    }
}
