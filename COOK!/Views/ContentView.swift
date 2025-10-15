//
//  ContentView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: String = "Grocery"
    @State private var tabsColor: Color = .pink
    @State private var backgroundColor: Color = Color(hue: 0.9361, saturation: 0.03, brightness: 1)
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
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
                    case "Home":
                        backgroundColor = Color(hue: 0.7444, saturation: 0.03, brightness: 0.99)
                        tabsColor = Color(hue: 0.7444, saturation: 0.46, brightness: 0.93)
                    case "Grocery":
                        tabsColor = .pink
                        backgroundColor = Color(hue: 0.9361, saturation: 0.03, brightness: 1)
                    case "Ingredients":
                        tabsColor = .yellow
                        backgroundColor = Color(hue: 0.1528, saturation: 0.04, brightness: 1)
                    case "Recipes":
                        tabsColor = Color(hue: 0.5611, saturation: 0.88, brightness: 1)
                        backgroundColor = Color(hue: 0.5611, saturation: 0.05, brightness: 1)
                    case "Plus":
                        tabsColor = .blue
                    case "Schedule":
                        tabsColor = Color(hue: 0.3389, saturation: 1, brightness: 0.85)
                        backgroundColor = Color(hue: 0.3389, saturation: 0.05, brightness: 1)
                    default:
                        tabsColor = .pink
                    }
                }
            }
            .background(backgroundColor)
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
