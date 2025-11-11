//
//  AddRecipeView.swift
//  COOK!
//
//  Created by Colin Butera on 11/6/25.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var appState: AppState
    
    @State private var recipeTitle = ""
    @State private var recipeDescription = ""
    @State private var recipeIngredients: [Ingredient] = []
    @State private var recipeSteps: [String] = []
    
    @State private var newIngredientName: String = ""
    @State private var newStep: String = ""
    @State private var newIngredientQuantity: Int = 0
    @State private var showAddItemAlert = false
    @State private var showAddStepAlert = false
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: Image?
    
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
            
//            HStack() {
                Text("Image")
                    .font(Font.title2.bold())
                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                PhotosPicker(
                    "Add Recipe Image",
                    selection: $selectedPhoto,
                    matching: .images
                )
                .photosPickerStyle(.presentation)
                .buttonStyle(.bordered)
                .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)
                .onChange(of: selectedPhoto) { _, newValue in
                    Task {
                        if let data = try await newValue?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                selectedImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                }

                
                Spacer()
                Spacer()
//            }
            
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

            Text("Instructions")
            Text("Instructions")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .padding([.leading, .top])
                .font(.title2.bold())
            
            List {
                ForEach(recipeSteps, id: \.self) { step in
                    Text(step)
                        .swipeActions {
                            Button(role: .destructive) {
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
            .scrollContentBackground(.hidden)
            .alert("Add New Step", isPresented: $showAddStepAlert) {
                TextField("Step", text: $newStep)
                Button("Add") {
                    if !newStep.isEmpty {
                        recipeSteps.append(newStep)
                        newStep = "" // Clear the text field
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Enter the name for the new item.")
            }
            
            
            
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
