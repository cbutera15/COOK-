//
//  GroceryListView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct GroceryListView: View {
    @State private var selectedItems: Set<String> = []
    private let items = ["Milk", "Eggs", "Cheese"]

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

            List(items, id: \.self, selection: $selectedItems) { item in
                Text(item)
            }
            .environment(\.editMode, .constant(.active))
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(hue: 0.9361, saturation: 0.03, brightness: 1)
            )

            Spacer()
        }
        .padding()
        .background(
            Color(hue: 0.9361, saturation: 0.03, brightness: 1)
        )
        // .bottomLine()
    }
}

#Preview {
    GroceryListView()
}
