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
    
    @State private var showEditRecipe = false
    
    var body: some View {
        VStack {
            Text(recipe.name).font(.largeTitle)
            Spacer()
            Text("Image") // placeholder
            Spacer()
            Text("Description") // placeholder
            Spacer()
            Text("Ingredients").font(.title2)
            IngredientList(
                ingredients: $recipe.ingredients,
                selected: $selected,
                color: .black,
                backgroundColor: .white,
                selectable: true,
                incrementable: false,
                deletable: false
            )
            Spacer()
            Text("Instructions").font(.title2)
            // add instructions here
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showEditRecipe = true}) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showEditRecipe) {
            EditRecipeView(recipe: $recipe, addRecipe: false)
                .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1)
    @State var chickenAndRice = Recipe(name: "Chicken and Rice", ingredients: [chicken, rice])
    
    RecipeView(recipe: $chickenAndRice)
}
