//
//  IngredientsView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject var appState: AppState
    
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
        
        
    }
    .padding()
    .background(appState.backgroundColor)
  }
}

#Preview {
    IngredientsView().environmentObject(AppState())
}
