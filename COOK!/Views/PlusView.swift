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
    @State private var showFromIngredients = false
    @State private var showFromTitle = false
    
    let lightPurple: Color = Color(hue: 0.7444, saturation: 0.05, brightness: 1)
    let purple: Color = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
    
    var body: some View {
        VStack() {
            Text("COOK!")
                .font(.title)
        
            Spacer()
            
            Button(action: {
                appState.signOut()
            }) {
                HStack {
                    Image(systemName: "person.badge.minus")
                    Text("Sign Out")
                        .font(.title)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(BorderedButtonStyle())
            .tint(purple)
            .padding(.horizontal)
            
            Button(action: {
                showAddRecipe = true
                newRecipe = Recipe()
            }) {
                Text("Create Recipe \nFrom Scratch")
                    .frame(maxWidth: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(purple)
            .sheet(isPresented: $showAddRecipe) {
                EditRecipeView(recipe: $newRecipe, addRecipe: true, showDay: false, selectedDay: "")
            }
            
            Button(action: {
                showFromIngredients = true
            }) {
                Text("Create Recipe \nfrom Ingredients")
                    .frame(maxWidth: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 15)
            .padding(.horizontal)
            .tint(purple)
            .sheet(isPresented: $showFromIngredients) {
                AddFromIngredientsView()
            }
            
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
