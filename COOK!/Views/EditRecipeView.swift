//
//  AddRecipeView.swift
//  COOK!
//
//  Created by Colin Butera on 11/6/25.
//

import SwiftUI
import PhotosUI

struct EditRecipeView: View {
    // Defining dismiss action
    @Environment(\.dismiss) private var dismiss
    
    // Environment object that handles current tab and colors
    @EnvironmentObject var appState: AppState
    @Binding var recipe: Recipe
    
    let addRecipe: Bool
    let showDay: Bool
    
    @State private var recipeTitle = ""
    @State private var recipeDescription = ""
    @State private var recipeIngredients: [Ingredient] = []
    @State private var recipeSteps: [String] = []
    
    // Add ingredient fields
    @State private var newIngredientName: String = ""
    @State private var newStep: String = ""
    @State private var newIngredientQuantity: Int = 1
    @State private var newIngredientUnitUnform: String = "None"
    @State private var newIngredientUnit: Ingredient.Unit = .none
    @State private var showAddItemAlert = false
    @State private var showAddStepAlert = false
    
    // Photo picker variables (encrypted photo, loaded photo)
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    // Days list
    @State private var days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State var selectedDay: String

    
    // Unit list
    let units = ["None", "Teaspoon", "Tablespoon", "Ounce", "Pound", "Milliliter", "Liter", "Kilogram", "Gram", "Gallon", "Cup"]
    
    // Custom colors
    let purple: Color = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
    let lightPurple: Color = Color(hue: 0.7444, saturation: 0.05, brightness: 1)
    let white: Color = .white
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
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

                    VStack(alignment: .leading, spacing: 16) {
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
                        .frame(minHeight: 200)
                        
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
                        .sheet(isPresented: $showAddItemAlert) {
                            VStack(spacing: 20) {
                                Spacer()
                                Text("Add New Item")
                                    .font(.title)
                                    .padding()
                                
                                Text("Ingredient Name")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2)
                                TextField("Ingredient Name", text: $newIngredientName)
                                    .textFieldStyle(.roundedBorder)
                                
                                Text("Ingredient Quantity")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title2)
                                TextField("Ingredent Quantity", value: $newIngredientQuantity, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                
                                HStack {
                                    Text("Unit: ")
                                    Picker("Unit", selection: $newIngredientUnitUnform) {
                                        ForEach(units, id: \.self) { unit in
                                            Text(unit)
                                        }
                                    }
                                    .scaleEffect(1.2)
                                }
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)

                                HStack {
                                    Button(action: {
                                        showAddItemAlert = false
                                    }) {
                                        Text("Cancel")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)

                                    Button(action: {
                                        switch newIngredientUnitUnform {
                                        case "None":
                                            newIngredientUnit = .none
                                        case "Teaspoon":
                                            newIngredientUnit = .teaspoon
                                        case "Tablespoon":
                                            newIngredientUnit = .tablespoon
                                        case "Ounce":
                                            newIngredientUnit = .ounce
                                        case "Pound":
                                            newIngredientUnit = .pound
                                        case "Milliliter":
                                            newIngredientUnit = .milliliter
                                        case "Liter":
                                            newIngredientUnit = .liter
                                        case "Kilogram":
                                            newIngredientUnit = .kilogram
                                        case "Gram":
                                            newIngredientUnit = .gram
                                        case "Gallon":
                                            newIngredientUnit = .gallon
                                        case "Cup":
                                            newIngredientUnit = .cup
                                        default:
                                            newIngredientUnit = .none
                                        }
                                        
                                        if !newIngredientName.isEmpty && newIngredientQuantity > 0 {
                                            recipeIngredients.append(
                                                Ingredient(
                                                    name: newIngredientName,
                                                    quantity: newIngredientQuantity,
                                                    unit: newIngredientUnit
                                                )
                                            )
                                            newIngredientName = ""
                                            newIngredientQuantity = 1
                                            showAddItemAlert = false
                                        }
                                    }) {
                                        Text("Add")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                                .padding(.top)

                                Spacer()
                            }
                            .presentationDetents([.height(400)])
                            .tint(purple)
                            .padding()
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
                        
                        if showDay {
                            VStack {
                                Text("Schedule Day to Add")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                                    .padding([.leading, .top])
                                    .font(.title2.bold())
                                
                                HStack {
                                    Text("Day:")
                                    
                                    Picker("Day", selection: $selectedDay) {
                                        ForEach(days, id: \.self) { day in
                                            Text(day)
                                                .tag(day)
                                        }
                                    }
                                    .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            }
                        }
                    
                }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hue: 0.7444, saturation: 0.05, brightness: 1))
                .onAppear {
                    // load current fields when editting
                    
                    recipeTitle = recipe.name
                    recipeDescription = recipe.description
                    // set current image to edit
                    recipeIngredients = recipe.ingredients
                    recipeSteps = recipe.instructions.split(separator: "\n").map(String.init)
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 12) {
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
                    
                    Button(action: {
                        dismiss()
                        
                        recipe = Recipe(
                            name: recipeTitle,
                            description: recipeDescription,
                            //imagePath: selectedImage!,
                            ingredients: recipeIngredients,
                            instructions: recipeSteps.joined(separator: "\n"),
                        )
                        if addRecipe {
                            appState.addSavedRecipe(recipe)
                            if showDay {
                                for (index, day) in days.enumerated() {
                                    if day == selectedDay {
                                        appState.schedule[index].addRecipe(recipe)
                                    }
                                }
                            }
                        }
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                }

                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.7444, saturation: 0.05, brightness: 1))
            .onAppear {
                // load current fields when editting
                
                recipeTitle = recipe.name
                recipeDescription = recipe.description
                // set current image to edit
                recipeIngredients = recipe.ingredients
                recipeSteps = recipe.instructions.split(separator: "\n").map(String.init)

            }
        }
        .background(lightPurple)
    }
}


#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2, unit: .pound)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1, unit: .cup)
    @State var chickenAndRice = Recipe(name: "Chicken and Rice", ingredients: [chicken, rice])
    @State var blankRecipe = Recipe()
    
    EditRecipeView(recipe: $chickenAndRice, addRecipe: false, showDay: false, selectedDay: "").environmentObject(AppState())
}

