//
//  ContentView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: String = "Grocery"
    @State private var showPlusMenu = false
    @State private var showAddRecipe = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("COOK")
                
                switch appState.selectedTab {
                    case .home:
                        HomeView()
                    case .groceryList:
                        GroceryListView()
                    case .pantry:
                        PantryView()
                    case .plus:
                        PlusView()
                    case .recipes:
                        RecipesView()
                    case .schedule:
                    ScheduleView(recipesHash: [], selectedRecipe: "", selectedDay: "", selectedTime: "")
                }
                
                HStack() {
                    CustomTabButton(
                        iconName: "list.dash",
                        destination: .groceryList,
                        tabColor: .pink,
                        appColor: Color(hue: 0.9361, saturation: 0.03, brightness: 1))
                    
                    CustomTabButton(
                        iconName: "cabinet",
                        destination: .pantry,
                        tabColor: .yellow,
                        appColor: Color(hue: 0.1528, saturation: 0.04, brightness: 1))
                    
                    CustomTabButton(
                        iconName: "plus",
                        destination: .plus,
                        tabColor: Color(hue: 0.7444, saturation: 0.46, brightness: 0.93),
                        appColor: Color(hue: 0.7444, saturation: 0.05, brightness: 1))
                    
                    CustomTabButton(
                        iconName: "bookmark",
                        destination: .recipes,
                        tabColor: Color(hue: 0.5611, saturation: 0.88, brightness: 1),
                        appColor: Color(hue: 0.5611, saturation: 0.05, brightness: 1))
                    
                    CustomTabButton(
                        iconName: "calendar",
                        destination: .schedule,
                        tabColor: Color(hue: 0.3389, saturation: 1, brightness: 0.85),
                        appColor: Color(hue: 0.3389, saturation: 0.05, brightness: 1)   )
                }
                .frame(maxWidth: .infinity)
                .background(appState.backgroundColor)
                .ignoresSafeArea(edges: .bottom)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black),
                    alignment: .top
                )
                
            }
            .background(appState.backgroundColor)
        }
        .onChange(of: appState.selectedTab) { oldValue, newValue in
            if newValue == .plus {
                appState.selectedTab = .plus
                showPlusMenu = true
            }
        }
        .confirmationDialog("What would you like to do?", isPresented: $showPlusMenu, titleVisibility: .visible) {
            Button("Add Recipe") {
                showPlusMenu = false
                showAddRecipe = true
            }
            Button("Add Ingredient") {
                // handle action
            }
            Button("Add to Grocery List") {
                // handle action
            }
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $showAddRecipe) {
            AddRecipeView()
                .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}

extension View {
  func bottomLine() -> some View {
    GeometryReader { geometry in
      self
        .frame(width: geometry.size.width, height: geometry.size.height).border(.black)
    }      .ignoresSafeArea(.all, edges: .top)
  }
}

