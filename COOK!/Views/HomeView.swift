//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//


import SwiftUI

struct HomeView: View {
  var body: some View {
      Text("COOK")
      
      
    TabView {
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
  HomeView()
}



extension View {
  func bottomLine() -> some View {
    GeometryReader { geometry in
      self
        .frame(width: geometry.size.width, height: geometry.size.height).border(.black)
    }      .ignoresSafeArea(.all, edges: .top)
  }
}


