//
//  IngredientsView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject var appState: AppState
    
    @State var ingredients: [Ingredient] = [
        Ingredient(name: "Milk", quantity: 1),
        Ingredient(name: "Eggs", quantity: 3)
    ]
    
  var body: some View {
    VStack {
        HStack {
            Image(systemName: "cabinet")
                .foregroundStyle(Color(hue: 0.1528, saturation: 3, brightness: 1))
                .padding()
            Text("Ingredients")
                .foregroundStyle(Color(hue: 0.1528, saturation: 3, brightness: 1))
            Spacer()
        }.font(Font.largeTitle.bold())
        
        Spacer()
        
        NavigationStack {
            HStack {
                NavigationLink("Scan Food", destination: ScanFoodView())
                
                Spacer()
                
                NavigationLink("Search Food", destination: SearchFoodView())
            }.padding()
        }
        
        Spacer()
        
        IngredientList(
            ingredients: $ingredients,
            selected: .constant([]),
            color: .black,
            backgroundColor: appState.backgroundColor,
            selectable: false,
            incrementable: true,
            deletable: false
        )
    }
    .padding()
    .background(appState.backgroundColor)
  }
}

#Preview {
    IngredientsView().environmentObject(AppState())
}
