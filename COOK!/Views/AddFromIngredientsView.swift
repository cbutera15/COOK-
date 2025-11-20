//
//  SwiftUIView.swift
//  COOK!
//
//  Created by Colin Butera on 11/20/25.
//

import SwiftUI

struct AddFromIngredientsView: View {
    @EnvironmentObject var appState: AppState
    
    let purple: Color = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
    let lightPurple: Color = Color(hue: 0.7444, saturation: 0.05, brightness: 1)
    
    private var suggestedRecipes: [Recipe] {
        var suggested = [Recipe]()
        for recipe in appState.savedRecipes {
            for ingredient in recipe.ingredients {
                if appState.ingredients.contains(where: { $0.name == ingredient.name }) {
                    suggested.append(recipe)
                    break
                }
            }
        }
        return suggested
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "sparkles")
                    .font(Font.title.bold())
                    
                Text("Suggested Recipes")
                    .font(Font.largeTitle.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .foregroundStyle(purple)
            
            ForEach(suggestedRecipes, id: \.id) { recipe in
                Text(recipe.name)
            }
            
            Spacer()
                
        }
        .background(lightPurple)
    }
}

#Preview {
    AddFromIngredientsView()
        .environmentObject(AppState())
}
