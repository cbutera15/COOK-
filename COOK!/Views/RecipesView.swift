//
//  RecipesView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI
import UIKit

struct RecipesView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                
                Spacer()
                
                List {
                    // Favorite section
                    if !appState.favoriteRecipes.isEmpty {
                        Section(header: Text("Favorite Recipes").font(.headline)) {
                            ForEach(appState.favoriteRecipes) { recipe in
                                RecipeRow(
                                    recipe: recipe,
                                    isFavorite: true,
                                    toggleFavorite: { toggleFavorite(recipe) }
                                )
                            }
                        }
                    }
                    
                    // All Recipes section
                    Section(header: Text("All Recipes").font(.headline)) {
                        ForEach(appState.savedRecipes) { recipe in
                            RecipeRow(
                                recipe: recipe,
                                isFavorite: appState.favoriteRecipes.contains(where: { $0.id == recipe.id }),
                                toggleFavorite: { toggleFavorite(recipe) }
                            )
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .tint(Color(hue: 0.9361, saturation: 0.84, brightness: 1))
                
                Spacer()
            }
            .padding(.horizontal)
            .background(appState.backgroundColor)
        }
    }
    
    private var header: some View {
        HStack {
            Image(systemName: "bookmark.fill")
                .foregroundStyle(Color(hue: 0.5611, saturation: 0.88, brightness: 1))
                .padding()
            Text("Recipe Library")
                .foregroundStyle(Color(hue: 0.5611, saturation: 0.88, brightness: 1))
            Spacer()
        }
        .font(.largeTitle.bold())
    }
    
    private func toggleFavorite(_ recipe: Recipe) {
        if let idx = appState.favoriteRecipes.firstIndex(where: { $0.id == recipe.id }) {
            appState.removeFromFavorites(recipe)
        } else {
            appState.addToFavorites(recipe)
        }
    }
}

// MARK: - Row View
struct RecipeRow: View {
    @State private var selectedIngredients: [Ingredient] = []
    
    @State var recipe: Recipe
    let isFavorite: Bool
    let toggleFavorite: () -> Void
    
    var body: some View {
        HStack {
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(.pink)
                    .font(.title3)
            }
            .buttonStyle(.plain)
            
            NavigationLink(destination: RecipeView(recipe: $recipe, selected: $selectedIngredients)) {
                Text(recipe.name)
                    .foregroundStyle(.primary)
            }
        }
        .listRowBackground(Color(hue: 0.9361, saturation: 0.008, brightness: 1))
    }
}

#Preview {
    RecipesView().environmentObject(AppState())
}
