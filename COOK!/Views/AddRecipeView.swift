//
//  AddRecipeView.swift
//  COOK!
//
//  Created by Colin Butera on 11/6/25.
//

import SwiftUI

struct AddRecipeView: View {
    @State private var recipeTitle = ""
    @State private var recipeDescription = ""
    @State private var recipeIngredients: [String] = []
    @State private var newIngredientName: String = ""
    
    @State private var showAddItemAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "text.badge.plus")
                    .padding()
                Text("Add Recipe")
                Spacer()
            }
            .font(Font.largeTitle.bold())
            .padding()
            .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
            
            Spacer()
            
            TextField("Recipe Title", text: $recipeTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Recipe Description", text: $recipeDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("Ingredients")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .padding([.leading, .top])
                .font(.title2.bold())
            
            List {
                ForEach(recipeIngredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                Button(action: {
                    showAddItemAlert = true
                }) {
                    Text("Add Ingredient")
                        .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                }
            }
            .scrollContentBackground(.hidden)
            .alert("Add New Item", isPresented: $showAddItemAlert) {
                TextField("Item Name", text: $newIngredientName)
                Button("Add") {
                    if !newIngredientName.isEmpty {
                        recipeIngredients.append(newIngredientName)
                        newIngredientName = "" // Clear the text field
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Enter the name for the new item.")
            }

            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.7444, saturation: 0.05, brightness: 1))
    }
}

#Preview {
    AddRecipeView()
}
