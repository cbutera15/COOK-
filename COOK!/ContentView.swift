//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//


import SwiftUI

struct HomeView: View {
  var body: some View {
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


struct GroceryListView: View {
  var body: some View {
      VStack {
        Image(systemName: "list.dash")
        Spacer().frame(width: 0, height: 50)
        Text("Grocery List View")
      }
      .padding()
      .bottomLine()
  }
}

#Preview {
  GroceryListView()
}


struct IngredientsView: View {
  var body: some View {
    VStack {
      Image(systemName: "cabinet")
      Spacer().frame(width: 0, height: 50)
      Text("Ingredients View")
    }
    .padding()
    .bottomLine()
  }
}


struct PlusView: View {
  var body: some View {
    VStack {
      Image(systemName: "plus")
      Spacer().frame(width: 0, height: 50)
      Text("Plus View")
    }
    .padding()
    .bottomLine()
  }
}

struct RecipesView: View {
  var body: some View {
    VStack {
      Image(systemName: "paperclip")
      Spacer().frame(width: 0, height: 50)
      Text("Recipes View")
    }
    .padding()
    .bottomLine()
  }
}

struct ScheduleView: View {
  var body: some View {
    VStack {
      Image(systemName: "calendar")
      Spacer().frame(width: 0, height: 50)
      Text("Schedule View")
    }
    .padding()
    .bottomLine()
  }
}

#Preview {
  IngredientsView()
}

extension View {
  func bottomLine() -> some View {
    GeometryReader { geometry in
      self
        .frame(width: geometry.size.width, height: geometry.size.height).border(.black)
    }      .ignoresSafeArea(.all, edges: .top)
  }
}


