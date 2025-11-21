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
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("COOK")
                
                switch appState.selectedTab {
                    case .signIn:
                        SignInView()
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
                    ScheduleView(recipesHash: [], selectedRecipe: "", selectedDay: "")
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
            //.frame(maxWidth: .infinity)
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
