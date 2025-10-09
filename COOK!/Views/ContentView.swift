//
//  ContentView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("COOK")
        
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                }
            GroceryListView()
                .tabItem() {
                    Image(systemName: "list.dash")
                }
            IngredientsView()
                .tabItem() {
                    Image(systemName: "cabinet")
                }
            PlusView()
                .tabItem() {
                    Image(systemName: "plus")
                }
            RecipesView()
                .tabItem {
                    Image(systemName: "bookmark")
                }
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
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
