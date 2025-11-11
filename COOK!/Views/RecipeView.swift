//
//  RecipeView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: Recipe
    
    @State var selected: [Ingredient] = []
    
    var body: some View {
        VStack {
            Text(recipe.name)
            Spacer()
            Text("Image")
            Spacer()
            Text("Ingredients")
            IngredientList(
                ingredients: $recipe.ingredients,
                selected: $selected,
                color: .black,
                backgroundColor: .white,
                selectable: true,
                incrementable: false,
                deletable: false)
            Spacer()
            Text("Instructions")
        }
        .padding()
        //.bottomLine()
        .navigationTitle(recipe.name)
    }
}

#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1)
    @State var chickenAndRice = Recipe(name: "Chicken and Rice", ingredients: [chicken, rice])
    
    RecipeView(recipe: $chickenAndRice)
}
