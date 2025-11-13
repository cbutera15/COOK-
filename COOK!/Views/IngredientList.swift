//
//  IngredientList.swift
//  COOK!
//
//  Created by Sam Zimpfer on 11/9/25.
//

import SwiftUI

struct IngredientList: View {
    @Binding var ingredients: [Ingredient]
    @Binding var selected: [Ingredient]
    
    let color: Color
    let backgroundColor: Color
    let selectable: Bool
    let incrementable: Bool
    let unitEditable: Bool
    let deletable: Bool
    
    var body: some View {
        List() {
            ForEach($ingredients) { $item in
                IngredientView(
                    ingredient: $item,
                    color: color,
                    backgroundColor: backgroundColor,
                    selectable: selectable,
                    incrementable: incrementable,
                    unitEditable: unitEditable,
                    deletable: deletable,
                    selected: selected.contains(where: { $0.id == item.id }),
                    onSelect: {
                        if let existingIndex = selected.firstIndex(where: { $0.id == item.id }) {
                            selected.remove(at: existingIndex)
                        } else {
                            selected.append(item)
                        }
                    },
                    onDelete: {
                        if let index = ingredients.firstIndex(where: { $0.id == item.id}) {
                            ingredients.remove(at: index)
                        }
                    }
                )
                .listRowBackground(backgroundColor)
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .tint(Color(hue: 0.9361, saturation: 0.84, brightness: 1))
    }
}

#Preview {
    @Previewable @State var ingredients: [Ingredient] = [
        Ingredient(name: "Milk", quantity: 1, unit: .gallon),
        Ingredient(name: "Eggs", quantity: 3)
    ]
    
    @Previewable @State var selected: [Ingredient] = []
    
    IngredientList(
        ingredients: $ingredients,
        selected: $selected,
        color: .blue,
        backgroundColor: .gray,
        selectable: true,
        incrementable: true,
        unitEditable: true,
        deletable: true
    )
}
