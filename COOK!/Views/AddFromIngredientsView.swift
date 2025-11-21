//
//  SwiftUIView.swift
//  COOK!
//
//  Created by Colin Butera on 11/20/25.
//

import SwiftUI

struct AddFromIngredientsView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    @State private var showAddedAlert = false
    @State private var lastAddedRecipeName: String = ""
    
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
            
            ScrollView {
                ForEach(suggestedRecipes.indices, id: \.self) { index in
                    let recipe = suggestedRecipes[index]
                    
                    HStack {
                        Text("\(index + 1). \(recipe.name)")
                        
                        Button(action: {
                            appState.addSavedRecipe(recipe)
                            lastAddedRecipeName = recipe.name
                            showAddedAlert = true
                        }) {
                            Image(systemName: "plus.circle")
                        }
                        
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                    .foregroundStyle(purple)
                    .padding([.top, .horizontal])
                    
                    Text(recipe.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                    ForEach(recipe.ingredients, id: \.id) { ingredient in
                        Text(ingredient.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
                }
            }
            .alert("Added", isPresented: $showAddedAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("\(lastAddedRecipeName) was added to your saved recipes.")
            }
            
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(purple)
            .padding()
                
        }
        .background(lightPurple)
    }
}

#Preview {
    AddFromIngredientsView()
        .environmentObject(AppState())
}
