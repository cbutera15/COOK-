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
    var showDelete: Bool
    
    let width: CGFloat = 150
    let height: CGFloat = 100
    
    var textOverlay: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(recipe.name)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.horizontal)
                    .background(
                        Rectangle()
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .cornerRadius(6)
                    )
            }
        }
        .cornerRadius(10)
        .padding()
    }
    
    var body: some View {
        if recipe.name == "" {
            Rectangle()
                .foregroundStyle(color)
                .scaledToFill()
                .frame(width: width, height: height)
                .cornerRadius(10)
                .overlay(alignment: .center, content: {
                    VStack {
                        Image(systemName: "plus")
                        Text("Add meal")
                            .bold()
                            .padding()
                    }
                })
        } else if recipe.imagePath == nil {
            Rectangle()
                .foregroundStyle(color)
                .scaledToFill()
                .frame(width: width, height: height)
                .cornerRadius(10)
                .overlay(
                    textOverlay
                )
        } else {
            recipe.imagePath?
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .cornerRadius(10)
                .overlay(
                    textOverlay
                )
        }
    }
}

#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1)
    @State var chickenAndRice = Recipe(
        name: "Chicken and Rice",
        imagePath: Image(systemName: "photo"),
        ingredients: [chicken, rice]
    )
    
    RecipeCardView(recipe: $chickenAndRice, color: .gray, showDelete: true)
}
