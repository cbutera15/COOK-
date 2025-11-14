//
//  PlusView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct PlusView: View {
    @EnvironmentObject var appState: AppState
    
    @State var showAddRecipe = false
    @State var newRecipe = Recipe()
    
    var body: some View {
        VStack {
            Button(action: {
                showAddRecipe = true
                newRecipe = Recipe()
            }) {
                Text("Add Recipe")
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showAddRecipe) {
                EditRecipeView(recipe: $newRecipe, addRecipe: true)
            }
            
            Button(action: {
                
            }) {
                Text("Edit Recipe")
            }
            Button(action: {
                
            }) {
                Text("Add with AI")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .padding()
        .background(appState.backgroundColor)
    }
}

#Preview {
    // Explicitly set preview background color to shadow what happens in deployment
    let state = AppState()
    state.selectedTab = .plus
    state.backgroundColor = Color(hue: 0.7444, saturation: 0.05, brightness: 1)
    return PlusView().environmentObject(state)
}
