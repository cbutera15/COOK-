//
//  AddRecipeView.swift
//  COOK!
//
//  Created by Colin Butera on 11/6/25.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var appState: AppState
    
    @State private var recipeTitle = ""
    @State private var recipeDescription = ""
    @State private var recipeIngredients: [Ingredient] = []
    
    @State private var newIngredientName: String = ""
    @State private var newIngredientQuantity: Int = 0
    
    @State private var showAddItemAlert = false
    
    let purple: Color = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
    let lightPurple: Color = Color(hue: 0.7444, saturation: 0.05, brightness: 1)
    let white: Color = .white
    
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
            
            Text("Title")
                .font(Font.title2.bold())
                .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            TextField("Recipe Title", text: $recipeTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Text("Description")
                .font(Font.title2.bold())
                .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top])
            TextField("Recipe Description", text: $recipeDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Text("Ingredients")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .padding([.leading, .top])
                .font(.title2.bold())
            
            IngredientList(
                ingredients: $recipeIngredients,
                selected: .constant([]),
                color: purple,
                backgroundColor: white,
                selectable: false,
                incrementable: true,
                unitEditable: true,
                deletable: true
            )
            
            Button(action: { showAddItemAlert = true }) {
                Text("Add Ingredient")
                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
            }
            .tint(white)
            .buttonStyle(BorderedButtonStyle())
            .contentShape(Rectangle())
            .alert("Add New Item", isPresented: $showAddItemAlert) {
                TextField("Item Name", text: $newIngredientName)
                TextField("Item Quantity", value: $newIngredientQuantity, format: .number)
                Button("Add") {
                    if !newIngredientName.isEmpty && newIngredientQuantity > 0 {
                        recipeIngredients.append(
                            Ingredient(
                                name: newIngredientName,
                                quantity: newIngredientQuantity
                            ))
                        newIngredientName = "" // Clear the text field
                        newIngredientQuantity = 0
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Enter the name for the new item.")
            }

            Spacer()
            
            // Cancel or save
            HStack {
                Button(action: {
                    dismiss()
                    recipeTitle = ""
                    recipeDescription = ""
                    recipeIngredients = []
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .padding(.leading)
                
                Button(action: {
                    dismiss()
                    
                    appState.addSavedRecipe(
                        Recipe(
                            name: recipeTitle,
                            description: recipeDescription,
                            imagePath: "",
                            ingredients: recipeIngredients,
                            instructions: []
                        )
                    )
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .padding(.trailing)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.7444, saturation: 0.05, brightness: 1))
    }
}

#Preview {
    AddRecipeView().environmentObject(AppState())
}
