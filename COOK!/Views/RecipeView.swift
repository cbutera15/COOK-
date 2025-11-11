//
//  RecipeView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.name)
            Spacer()
            Text("Image")
            Spacer()
            Text("Ingredients")
            Spacer()
            Text("Instructions")
        }
        .padding()
        //.bottomLine()
        .navigationTitle(recipe.name)
    }
}

#Preview {
    RecipeView(recipe: Recipe(name:"Chicken and Pasta"))
}
