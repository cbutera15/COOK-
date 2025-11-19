//
//  RecipeCardView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 11/19/25.
//

import SwiftUI

struct RecipeCardView: View {
    @Binding var recipe: Recipe
    
    var color: Color
    
    var body: some View {
        if recipe.name == "" {
            Rectangle()
                .foregroundStyle(color)
                .scaledToFill()
                .frame(width: 200, height: 100)
                .cornerRadius(10)
                .overlay(alignment: .center, content: {
                    VStack {
                        Image(systemName: "plus")
                        Text("Add meal")
                            .bold()
                            .padding()
                    }
                })
        } else {
            Image(recipe.imagePath)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 100)
                .cornerRadius(10)
                .overlay(alignment: .bottomTrailing, content: {
                    Text(recipe.name)
                        .bold()
                        .padding()
                })
        }
    }
}

#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1)
    @State var chickenAndRice = Recipe(name: "Chicken and Rice", ingredients: [chicken, rice])
    
    RecipeCardView(recipe: $chickenAndRice, color: .gray)
}
