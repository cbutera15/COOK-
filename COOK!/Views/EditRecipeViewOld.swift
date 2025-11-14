//
//  EditRecipeView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 11/11/25
//

import SwiftUI

struct EditRecipeViewOld: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var appState: AppState
    @Binding var recipe: Recipe
    
    let addRecipe: Bool
    
    @State private var recipeTitle = ""
    @State private var recipeDescription = ""
    @State private var recipeIngredients: [Ingredient] = []
    @State private var recipeSteps: [String] = []
    
    // Add ingredient fields
    @State private var newIngredientName: String = ""
    @State private var newStep: String = ""
    @State private var newIngredientQuantity: Int = 1
    @State private var newIngredientUnit: Ingredient.Unit = .none
    @State private var showAddItemAlert = false
    @State private var showAddStepAlert = false
    
    // Photo picker variables (encrypted photo, loaded photo)
    //@State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    // Custom colors
    let purple: Color = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
    let lightPurple: Color = Color(hue: 0.7444, saturation: 0.05, brightness: 1)
    let white: Color = .white
    
    var body: some View {
        VStack {
            HStack {
                if addRecipe {
                    Image(systemName: "text.badge.plus")
                        .padding()
                    Text("Add Recipe")
                } else {
                    Image(systemName: "square.and.pencil")
                        .padding()
                    Text("Edit Recipe")
                }
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
                        newIngredientQuantity = 1
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
                    recipe.setName(recipeTitle)
                    recipe.setDescription(recipeDescription)
                    recipe.setIngredients(recipeIngredients)
                    
                    print(recipe)
                    print("After dismiss")
                    
                    if addRecipe {
                        appState.addSavedRecipe(recipe)
                    }
                    
                    dismiss()
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
        .onAppear {
            recipeTitle = recipe.name
            recipeDescription = recipe.description
            recipeIngredients = recipe.ingredients
        }

    }
}

#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1)
    @State var chickenAndRice = Recipe(name: "Chicken and Rice", ingredients: [chicken, rice])
    @State var blankRecipe = Recipe()
    
    //EditRecipeView(recipe: $chickenAndRice, addRecipe: false).environmentObject(AppState())
    EditRecipeViewOld(recipe: $chickenAndRice, addRecipe: false).environmentObject(AppState())
}
