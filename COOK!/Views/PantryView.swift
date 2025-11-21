//
//  IngredientsView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct PantryView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var showScanBarcode = false
    @State var newScan = ScanFoodView()
    
    let yellow: Color = Color(hue: 0.1528, saturation: 3, brightness: 1)
    let lightYellow: Color = Color(hue: 0.1528, saturation: 2, brightness: 1)

    
  var body: some View {
    VStack {
        HStack {
            Image(systemName: "cabinet")
                .foregroundStyle(yellow)
                .padding()
            Text("Pantry")
                .foregroundStyle(yellow)
            Spacer()
        }.font(Font.largeTitle.bold())
        
        Spacer()
        
        Button(action: {
            showScanBarcode = true
            newScan = ScanFoodView()
        }) {
            Text("Scan Barcode")
                .frame(maxWidth: .infinity)
                .font(.title)
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .tint(lightYellow)
        .sheet(isPresented: $showScanBarcode) {
            newScan
        }
//        NavigationStack {
//            HStack {
//                NavigationLink("Scan Food", destination: ScanFoodView())
//                
//                Spacer()
//                
//                NavigationLink("Search Food", destination: SearchFoodView())
//            }.padding()
//        }
        
        Spacer()
        
        IngredientList(
            ingredients: $appState.ingredients,
            selected: .constant([]),
            color: .black,
            backgroundColor: appState.backgroundColor,
            selectable: false,
            incrementable: true,
            unitEditable: false,
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
