//
//  GroceryListView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI
import UIKit

struct GroceryListView: View {
    @EnvironmentObject var appState: AppState
    
    // context menu variables
    @State private var showAddItemMenu = false
    @State private var showClearMenu = false
    @State private var itemToAdd = ""
    @State private var unitToAdd = "None"
    @State private var ingredientUnit: Ingredient.Unit = .none
    @State private var quantity = 0
    
    let units = ["None", "Teaspoon", "Tablespoon", "Ounce", "Pound", "Milliliter", "Liter", "Kilogram", "Gram", "Gallon", "Cup"]
    let pink: Color = Color(hue: 0.9361, saturation: 0.84, brightness: 1)
    let white: Color = Color(hue: 0.9361, saturation: 0.008, brightness: 1)

    var body: some View {
        VStack {
            // Heading + Title
            HStack {
                Image(systemName: "list.dash")
                    .foregroundStyle(pink)
                    .padding()
                Text("Grocery List")
                    .foregroundStyle(pink)
                Spacer()
            }
            .font(Font.largeTitle.bold())

            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                // List content
                IngredientList(
                    ingredients: $appState.groceryList,
                    selected: $appState.selectedGroceryItems,
                    color: pink,
                    backgroundColor: white,
                    selectable: true,
                    incrementable: true,
                    unitEditable: true,
                    deletable: true
                )
                
                Spacer()
                
                VStack() {
                    Button(action: {
                        appState.addToPantry(appState.selectedGroceryItems)
                    }) {
                        Text("Add selected to pantry").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    // Clear and add buttons
                    HStack(spacing: 8) {
                        // Clear Button
                        Button(action: {
                            showClearMenu = true
                        }) {
                            Text("Clear")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        // Context menu for clearing
                        .sheet(isPresented: $showClearMenu) {
                            VStack {Button(action: {
                                    appState.removeFromGroceryList(appState.selectedGroceryItems)
                                    appState.selectedGroceryItems = []
                                    showClearMenu = false
                                }) {
                                    Text("Clear selected").frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                                
                                Button(action: {
                                    appState.groceryList = []
                                    showClearMenu = false
                                }) {
                                    Text("Clear all").frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                                
                                Button(action: { showClearMenu = false }) {
                                    Text("Cancel").frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .presentationDetents([.height(250)])
                            .padding(.horizontal, 50)
                        }
                        
                        // Add Item button updates showAddItemMenu
                        Button(action: {
                            showAddItemMenu = true
                            quantity = 0
                        }) {
                            Text("Add Item")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        // Context menu for adding an item
                        .sheet(isPresented: $showAddItemMenu) {
                            VStack() {
                                TextField(
                                    "Item Name",
                                    text: $itemToAdd)
                                .textFieldStyle(.roundedBorder)
                                    .padding()
                                Stepper("Quantity: \(quantity)", value: $quantity, in: 0...100)
                                    .padding()
                                HStack {
                                    Text("Unit:")
                                        .padding()
                                    Spacer()
                                    Picker("Unit", selection: $unitToAdd) {
                                        ForEach(units, id: \.self) { unit in
                                            Text(unit)
                                        }
                                    }
                                    .padding()
                                }
     
                                HStack {
                                    // Cancel Button
                                    Button(action: {
                                        showAddItemMenu = false
                                        itemToAdd = ""
                                    }) {
                                        Text("Cancel")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)
                                    .padding()
                                    
                                    // Add Item button
                                    Button(action: {
                                        switch unitToAdd {
                                        case "None":
                                            ingredientUnit = .none
                                        case "Teaspoon":
                                            ingredientUnit = .teaspoon
                                        case "Tablespoon":
                                            ingredientUnit = .tablespoon
                                        case "Ounce":
                                            ingredientUnit = .ounce
                                        case "Pound":
                                            ingredientUnit = .pound
                                        case "Milliliter":
                                            ingredientUnit = .milliliter
                                        case "Liter":
                                            ingredientUnit = .liter
                                        case "Kilogram":
                                            ingredientUnit = .kilogram
                                        case "Gram":
                                            ingredientUnit = .gram
                                        case "Gallon":
                                            ingredientUnit = .gallon
                                        case "Cup":
                                            ingredientUnit = .cup
                                        default:
                                            ingredientUnit = .none
                                        }
                                        
                                        if !itemToAdd.isEmpty {
                                            appState.addToGroceryList(name: itemToAdd, quantity: quantity, unit: ingredientUnit)
                                            showAddItemMenu = false
                                            itemToAdd = ""
                                        }
                                    }) {
                                        Text("Add")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .padding()
                                }
                            }
                            .presentationDetents([.height(300)])
                        }
                    }
                }
                .padding(.horizontal)
                .tint(pink)
                
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(appState.backgroundColor)
    }
}

#Preview {
    GroceryListView().environmentObject(AppState())
}
