//
//  RecipeView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var appState: AppState
    
    @Binding var recipe: Recipe
    @Binding var selected: [Ingredient]
    
    @State private var showEditRecipe = false
    
    var body: some View {
        VStack {
            Text(recipe.name).font(.largeTitle)
            Spacer()
            if (recipe.imagePath != nil) {
                recipe.imagePath?
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
            }
            Spacer()
            Text("Description")
                .font(.title2)
            Text(recipe.description)
            Spacer()
            Text("Ingredients").font(.title2)
            HStack {
//                Image(systemName: "cart")
//                Text("Ingredient status unavailable")
//                    .foregroundStyle(.secondary)
            }
            IngredientList(
                ingredients: $recipe.ingredients,
                selected: $selected,
                color: .black,
                backgroundColor: .white,
                selectable: true,
                incrementable: false,
                unitEditable: false,
                deletable: false
            )
            Spacer()
            Text("Instructions").font(.title2)
            let recipeSteps = recipe.instructions.split(separator: "\n").map(String.init)
            ForEach(recipeSteps, id: \.self) { step in
                Text(step)
            }
            Spacer()
        }
        .background(appState.backgroundColor)
//        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showEditRecipe = true}) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showEditRecipe) {
            EditRecipeView(recipe: $recipe, addRecipe: false, showDay: false, selectedDay: "")
                .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2, unit: .pound)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1, unit: .cup)
    @State var chickenAndRice = Recipe(name: "Chicken and Rice", ingredients: [chicken, rice])
    @State var selected: [Ingredient] = []
    return RecipeView(recipe: $chickenAndRice, selected: $selected)
        .environmentObject(AppState())
}
