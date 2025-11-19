//
//  PlusView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct PlusView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var showAddRecipe = false
    @State var newRecipe = Recipe()
    
    var body: some View {
        VStack {
            Button(action: {
                showAddRecipe = true
                newRecipe = Recipe()
            }) {
                Text("Add Recipe")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(.purple)
            .sheet(isPresented: $showAddRecipe) {
                EditRecipeView(recipe: $newRecipe, addRecipe: true)
            }
            
            Button(action: {
                
            }) {
                Text("Edit Recipe")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(.purple)
            
            Button(action: {
                
            }) {
                Text("Add with AI")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(.purple)
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
