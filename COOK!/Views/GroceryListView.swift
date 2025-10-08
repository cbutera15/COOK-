//
//  GroceryListView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct GroceryListView: View {
    @State private var selectedItems: Set<String> = []
    @State private var items: [String] = ["Milk", "Eggs", "Cheese"]

    var body: some View {
        VStack {
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
            
            VStack(alignment: .leading, spacing: 0) {
                List(items, id: \.self, selection: $selectedItems) { item in
                    Text(item)
                        .listRowBackground(Color(hue: 0.9361, saturation: 0.008, brightness: 1))
                }
                .environment(\.editMode, .constant(.active))
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .tint(Color(hue: 0.9361, saturation: 0.84, brightness: 1))
                
                HStack(spacing: 8) {
                    Button(action: { items = [] }) {
                        Text("Clear")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button(action: { /*
                                      PLACEHOLDER
                                      */ }) {
                        Text("Add Item")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
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
