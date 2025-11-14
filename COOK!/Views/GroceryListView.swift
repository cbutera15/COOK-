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
    @State private var quantity = 0
    
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
                                    // Cancel Button
                                    Button(action: {
                                        showAddItemMenu = false
                                        itemToAdd = ""
                                    }) {
                                        Text("Cancel")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    // Add Item button
                                    Button(action: {
                                        if !itemToAdd.isEmpty {
                                            appState.addToGroceryList(name: itemToAdd, quantity: quantity)
                                            showAddItemMenu = false
                                            itemToAdd = ""
                                        }
                                    }) {
                                        Text("Add")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                            .presentationDetents([.height(200)])
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
