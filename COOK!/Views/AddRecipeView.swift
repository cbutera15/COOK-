//
//  AddRecipeView.swift
//  COOK!
//
//  Created by Colin Butera on 11/6/25.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    // Defining dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // Environment object that handles current tab and colors
    @EnvironmentObject var appState: AppState
    
    // Add recipe fields
    @State private var recipeTitle = ""
    @State private var recipeDescription = ""
    @State private var recipeIngredients: [Ingredient] = []
    @State private var recipeSteps: [String] = []
    
    // Add ingredient fields
    @State private var newIngredientName: String = ""
    @State private var newStep: String = ""
    @State private var newIngredientQuantity: Int = 0
    @State private var showAddItemAlert = false
    @State private var showAddStepAlert = false
    
    // Photo picker variables (encrypted photo, loaded photo)
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    // Custom colors
    let purple: Color = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
    let lightPurple: Color = Color(hue: 0.7444, saturation: 0.05, brightness: 1)
    let white: Color = .white
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "text.badge.plus")
                        .padding()
                    Text("Add Recipe")
                    Spacer()
                }
                .font(Font.largeTitle.bold())
                .padding()
                .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                
                // Add recipe title
                Text("Title")
                    .font(Font.title2.bold())
                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                TextField("Recipe Title", text: $recipeTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Add recipe description
                Text("Description")
                    .font(Font.title2.bold())
                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                TextField("Recipe Description", text: $recipeDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Add recipe image
                Text("Image")
                    .font(Font.title2.bold())
                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                // SwiftUI built in photo picker
                PhotosPicker(
                    "+ Add Recipe Image",
                    selection: $selectedPhoto,
                    matching: .images
                )
                .photosPickerStyle(.presentation)
                .buttonStyle(.bordered)
                .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)
                // Load new image using key from photo picker
                .onChange(of: selectedPhoto) { _, newValue in
                    Task {
                        if let data = try await newValue?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                selectedImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                }
                
                // Show image if loaded correctly
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                }
                
                // Add ingredients to recipe
                Text("Ingredients")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                    .padding([.leading, .top])
                    .font(.title2.bold())
                
                // Custom IngredientList
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
                
                Button(action: {
                    showAddItemAlert = true
                }) {
                    Text("+ Add Ingredient")
                        .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                }
                .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .buttonStyle(BorderedButtonStyle())
                .contentShape(Rectangle())
                .padding(.horizontal)
                // Add ingredient diologue
                .alert("Add New Item", isPresented: $showAddItemAlert) {
                    TextField("Item Name", text: $newIngredientName)
                    TextField("Item Quantity", value: $newIngredientQuantity, format: .number)
                    Button("Add") {
                        // Conditionally constructing new ingredient item
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
                
                // Add recipe instructions
                Text("Instructions")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                    .padding([.leading, .top])
                    .font(.title2.bold())
                
                // Recipe intructions list
                List {
                    ForEach(recipeSteps, id: \.self) { step in
                        Text(step)
                            // Custom delete button
                            .swipeActions {
                                Button(role: .destructive) {
                                    // Remove ingredients based on index
                                    if let idx = recipeSteps.firstIndex(of: step) {
                                        recipeSteps.remove(at: idx)
                                    }
                                } label: {
                                    Text("Delete")
                                }
                                .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                            }
                    }
                    Button(action: {
                        showAddStepAlert = true
                    }) {
                        Text("Add Step")
                            .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                    }
                }
                .frame(minHeight: 300, maxHeight: 1000)
                .scrollContentBackground(.hidden)
                // Custom button added to button of list
                .alert("Add New Step", isPresented: $showAddStepAlert) {
                    TextField("Step", text: $newStep)
                    // Add new step to instructions
                    Button("Add") {
                        if !newStep.isEmpty {
                            recipeSteps.append(newStep)
                            newStep = ""
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Enter the name for the new item.")
                }
                
                HStack {
                    // Cancel button resets placeholders
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
                    
                    // Save button creates a new recipe and adds it to master list (to change when firebase connectione established)
                    Button(action: {
                        dismiss()
                        
                        appState.addSavedRecipe(
                            Recipe(
                                name: recipeTitle,
                                description: recipeDescription,
                                imagePath: "",
                                ingredients: recipeIngredients,
                                instructions: recipeSteps
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.7444, saturation: 0.05, brightness: 1))
        }
        .background(lightPurple)
    }
}


#Preview {
    AddRecipeView().environmentObject(AppState())
}
