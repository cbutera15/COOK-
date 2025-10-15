//
//  ContentView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: String = "Grocery"
    @State private var tabsColor: Color = .blue
    
    var body: some View {
        ZStack(alignment: .top) {
            Text("COOK")
            
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem() {
                        Image(systemName: "house")
                    }
                    .tag("Home")
                GroceryListView()
                    .tabItem() {
                        Image(systemName: "list.dash")
                    }
                    .tag("Grocery")
                IngredientsView()
                    .tabItem() {
                        Image(systemName: "cabinet")
                    }
                    .tag("Ingredients")
                PlusView()
                    .tabItem() {
                        Image(systemName: "plus")
                    }
                    .tag("Plus")
                RecipesView()
                    .tabItem {
                        Image(systemName: "bookmark")
                    }
                    .tag("Recipes")
                ScheduleView()
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                    .tag("Schedule")
            }
            .tint(tabsColor)
            .onChange(of: selectedTab) { oldTab, newTab in
                switch newTab {
                case "Grocery":
                    tabsColor = .pink
                case "Ingredients":
                    tabsColor = .yellow
                case "Recipes":
                    tabsColor = Color(hue: 0.5611, saturation: 0.88, brightness: 1)
                case "Schedule":
                    tabsColor = Color(hue: 0.3389, saturation: 1, brightness: 0.85)
                default:
                    tabsColor = .blue
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
  func bottomLine() -> some View {
    GeometryReader { geometry in
      self
        .frame(width: geometry.size.width, height: geometry.size.height).border(.black)
    }      .ignoresSafeArea(.all, edges: .top)
  }
}
