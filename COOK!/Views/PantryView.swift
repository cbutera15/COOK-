//
//  IngredientsView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct PantryView: View {
    @EnvironmentObject var appState: AppState
    
  var body: some View {
    VStack {
        HStack {
            Image(systemName: "cabinet")
                .foregroundStyle(Color(hue: 0.1528, saturation: 3, brightness: 1))
                .padding()
            Text("Pantry")
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
            ingredients: $appState.ingredients,
            selected: .constant([]),
            color: .black,
            backgroundColor: appState.backgroundColor,
            selectable: false,
            incrementable: true,
            deletable: true
        )
    }
    .padding()
    .background(appState.backgroundColor)
  }
}

#Preview {
    PantryView().environmentObject(AppState())
}
