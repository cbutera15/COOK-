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
    @State private var selectedItems: [Ingredient] = []
    @State private var items: [Ingredient] = [Ingredient(name: "Milk", quantity: 1), Ingredient(name: "Eggs", quantity: 2), Ingredient(name: "Cheese", quantity: 3)]
    @State private var quantity = 0
    
    // For Adding Items
    @State private var showAddItemMenu = false
    @State private var itemToAdd = ""

    var body: some View {
        VStack {
            // Heading + Title
            HStack {
                Image(systemName: "list.dash")
                    .foregroundStyle(Color(hue: 0.9361, saturation: 0.84, brightness: 0.98))
                    .padding()
                Text("Grocery List")
                    .foregroundStyle(Color(hue: 0.9361, saturation: 0.84, brightness: 0.98))
                Spacer()
            }
            .font(Font.largeTitle.bold())

            Spacer()
            
            // List content
            VStack(alignment: .leading, spacing: 0) {
                // Actual list
                List() {
                    ForEach(items) { item in
                        HStack {
                            // Custom checkmark to allow for selection and deletion
                            Image(systemName: selectedItems.contains(where: { $0.id == item.id }) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(Color(hue: 0.9361, saturation: 0.84, brightness: 1))
                                .font(.title3)
                            HStack {
                                Text(item.name)
                                    .listRowBackground(Color(hue: 0.9361, saturation: 0.008, brightness: 1))
                                // Allows deletion
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            // checking items against their unique item ids.
                                            if let idx = items.firstIndex(where: { $0.id == item.id }) {
                                                items.remove(at: idx)
                                            }
                                        } label: {
                                            Text("Delete")
                                        }.tint(Color(hue: 0.9361, saturation: 1, brightness: 0.76))
                                    }
                                Spacer()
                                Text(String(item.quantity))
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // Matching item IDS
                            if let idx = selectedItems.firstIndex(where: { $0.id == item.id }) {
                                selectedItems.remove(at: idx)
                            } else {
                                selectedItems.append(item)
                            }
                        }
                        
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .tint(Color(hue: 0.9361, saturation: 0.84, brightness: 1))
            
                
                // Clear and add buttons
                HStack(spacing: 8) {
                    // Clear Button
                    Button(action: { items = [] }) {
                        Text("Clear")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
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
                                        items.append(Ingredient(name: itemToAdd, quantity: quantity))
                                        showAddItemMenu = false
                                        itemToAdd = ""
                                    }
                                }) {
                                    Text("Add")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .padding(.horizontal)
                        }
                        .presentationDetents([.height(200)])
                    }
                }
                .tint(Color(hue: 0.9361, saturation: 0.84, brightness: 1))
                .padding(.horizontal)
                
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
