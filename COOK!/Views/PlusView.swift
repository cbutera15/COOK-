//
//  PlusView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct PlusView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var showSearch = false
    @State var newRecipe = Recipe()
    
    @State private var showFromIngredients = false
    @State private var showFromTitle = false
    @State private var showFromCategory = false
    @State private var showFromNumSteps = false
    @State private var showFromNumIngredients = false
    
    @State private var searchByString = true
    @State private var searchByNum = false
    @State private var searchString = ""
    
    
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
                showSearch = true
                newRecipe = Recipe()
            }) {
                Text("Create Recipe")
                    .frame(maxWidth: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(purple)
            .sheet(isPresented: $showSearch) {
                EditRecipeView(recipe: $newRecipe, addRecipe: true, showDay: false, selectedDay: "")
            }
            
            Text("Search")
                .font(Font.title2.bold())
                .foregroundStyle(Color(hue: 0.7444, saturation: 0.46, brightness: 0.93))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top])
            
            Button(action: {
                searchByNum = searchByString
                searchByString = !searchByNum
            }) {
                Text("Change search mode")
                    .frame(maxWidth: .infinity)
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 15)
            .padding(.horizontal)
            .tint(purple)
            
            if searchByNum{
                HStack{
                    Text("Lower range:")
                    Text(String(appState.searchLower))
                    VStack() {
                        Button(action: { appState.changeLowerSearch(1)}) {
                            Image(systemName: "chevron.up").foregroundStyle(Color.white)
                        }
                            .buttonStyle(PlainButtonStyle())
                        Button(action: { appState.changeLowerSearch(-1)}) {
                            Image(systemName: "chevron.down").foregroundStyle(Color.white)
                        }
                            .buttonStyle(PlainButtonStyle())
                    }
                    Text("Upper range:")
                    Text(String(appState.searchUpper))
                    VStack() {
                        Button(action: { appState.changeUpperSearch(1)}) {
                            Image(systemName: "chevron.up").foregroundStyle(Color.white)
                        }
                            .buttonStyle(PlainButtonStyle())
                        Button(action: { appState.changeUpperSearch(-1)}) {
                            Image(systemName: "chevron.down").foregroundStyle(Color.white)
                        }
                            .buttonStyle(PlainButtonStyle())
                    }
                }.padding(.top,13)
                Button(action: {
                    appState.searchFeild = "num_steps"
                    showFromNumSteps = true
                }) {
                    Text("Search Recipe By \nNumber of Steps")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 15)
                .padding(.horizontal)
                .tint(purple)
                .sheet(isPresented: $showFromNumSteps) {
                    AddRecipeView()
                }
                Button(action: {
                    appState.searchFeild = "num_ingredients"
                    showFromIngredients = true
                }) {
                    Text("Search Recipe By \nNumber of Ingredients")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 15)
                .padding(.horizontal)
                .tint(purple)
                .sheet(isPresented: $showFromIngredients) {
                    AddRecipeView()
                }
                Button(action: appState.updateBackend) {
                    Text("Search Recipe By \nNumber of Ingredients")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 15)
                .padding(.horizontal)
                .tint(purple)
                .hidden()
                .disabled(true)
            }
            
            if searchByString{
                TextField("Search for recipes", text: $searchString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    appState.searchName = searchString
                    appState.searchFeild = "category"
                    showFromTitle = true
                }) {
                    Text("Search Recipe \nBy Category")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 15)
                .padding(.horizontal)
                .tint(purple)
                .sheet(isPresented: $showFromCategory) {
                    AddRecipeView()
                }
                
                Button(action: {
                    appState.searchName = searchString
                    appState.searchFeild = "title"
                    showFromTitle = true
                }) {
                    Text("Search Recipe \nBy Title")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 15)
                .padding(.horizontal)
                .tint(purple)
                .sheet(isPresented: $showFromTitle) {
                    AddRecipeView()
                }
                
                
                Button(action: {
                    appState.searchFeild = "title"
                    showFromIngredients = true
                }) {
                    Text("Search Recipe \nBy Ingredients")
                        .frame(maxWidth: .infinity)
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 15)
                .padding(.horizontal)
                .tint(purple)
                .sheet(isPresented: $showFromIngredients) {
                    AddRecipeView()
                }
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
