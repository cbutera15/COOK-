//
//  GroceryListView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI
import UIKit

struct GroceryListView: View {
    @State private var selectedItems: Set<String> = []
    @State private var items: [String] = ["Milk", "Eggs", "Cheese"]
    
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
                List(selection: $selectedItems) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .listRowBackground(Color(hue: 0.9361, saturation: 0.008, brightness: 1))
                            .swipeActions {
                                Button("Delete") {
                                    print("h")
                                }
                                .tint(.red)
                            }
                    }
//                    .onDelete { indexSet in
//                        items.remove(atOffsets: indexSet)
//                    }
                }
                .environment(\.editMode, .constant(.active))
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
                    Button(action: { showAddItemMenu = true }) {
                        Text("Add Item")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    // Context menu for adding an item
                    .sheet(isPresented: $showAddItemMenu) {
                        VStack(spacing: 10) {
                            TextField(
                                "Item Name",
                                text: $itemToAdd)
                            .textFieldStyle(.roundedBorder)
                                .padding()
                            HStack {
                                Button(action: {
                                    showAddItemMenu = false
                                    itemToAdd = ""
                                }) {
                                    Text("Cancel")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                                Button(action: {
                                    if !itemToAdd.isEmpty {
                                        items.append(itemToAdd)
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
                        .presentationDetents([.height(150)])
                    }
                }
                .tint(Color(hue: 0.9361, saturation: 0.84, brightness: 1))
                .padding(.horizontal)
                
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(hue: 0.9361, saturation: 0.03, brightness: 1))
    }
}

#Preview {
    GroceryListView()
}
