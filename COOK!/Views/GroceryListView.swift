//
//  GroceryListView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct GroceryListView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "list.dash").padding()
                Text("Grocery List")
                Spacer()
            }.font(Font.largeTitle.bold())
            Spacer()
            
        @State var selectedItems: Set<String> = []
        let items = ["Milk", "Eggs", "Cheese"]
        List(items, id: \.self, selection: $selectedItems) { item in
            Text(item)
        }
        .environment(\.editMode, .constant(.active))
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        Spacer()
            
      }
      .padding()
      .bottomLine()
  }
}

#Preview {
    GroceryListView()
}
