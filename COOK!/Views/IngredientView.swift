//
//  Ingredient.swift
//  COOK!
//
//  Created by Sam Zimpfer on 11/9/25.
//

import SwiftUI

struct IngredientView: View {
    @Binding var ingredient: Ingredient
    
    let color: Color
    let backgroundColor: Color
    let selectable: Bool
    let incrementable: Bool
    let unitEditable: Bool
    let deletable: Bool
    
    var selected: Bool
    var onSelect: (() -> Void)
    var onDelete: (() -> Void)
    
    var body: some View {
        
        HStack {
            if (selectable) {
                // Custom checkmark to allow for selection and deletion
                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(color)
                    .font(.title3)
            }
            
            Text(ingredient.name).foregroundStyle(.black)
            
            Spacer()
            
            if incrementable {
                VStack() {
                    Button(action: { ingredient.increment() }) {
                        Image(systemName: "chevron.up").foregroundStyle(color)
                    }
                        .buttonStyle(PlainButtonStyle())
                    Button(action: { ingredient.decrement() }) {
                        Image(systemName: "chevron.down").foregroundStyle(color)
                    }
                        .buttonStyle(PlainButtonStyle())
                }
            }
            
            if unitEditable {
                Menu {
                    ForEach(Ingredient.Unit.allSorted, id: \.self) { unit in
                        Button(action: { ingredient.setUnit(unit) }) {
                            Text(unit.name.name)
                        }
                    }
                } label: {
                    Text(ingredient.displayQuantity())
                        .foregroundStyle(color)
                        .padding(.horizontal, 4)
                        .background(RoundedRectangle(cornerRadius: 6)
                            .fill(.gray.opacity(0.2))
                        )
                }
            } else {
                Text(String(ingredient.displayQuantity()))
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onSelect()
        }
        .swipeActions {
            if deletable {
                Button(action: onDelete) {
                    Text("Delete")
                }
                .tint(color)
            }
        }
    }
}

#Preview {
    @Previewable @State var ingredient: Ingredient = Ingredient(name: "Milk", quantity: 1, unit: .cup)
    
    IngredientView(
        ingredient: $ingredient,
        color: .blue,
        backgroundColor: .gray,
        selectable: true,
        incrementable: true,
        unitEditable: true,
        deletable: true,
        selected: false,
        onSelect: {},
        onDelete: {}
    )
}
