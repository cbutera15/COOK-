//
//  Recipe.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/24/25.
//

import Foundation

struct Recipe: Identifiable {
    var name: String
    let id = UUID()
    
    init(name: String) {
        self.name = name
    }
}
