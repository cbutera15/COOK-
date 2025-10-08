//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//


import SwiftUI

struct HomeView: View {
  var body: some View {
      Text("HOME")
      
      
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
    @State private var selectedItems: Set<String> = []
    private let items = ["Milk", "Eggs", "Cheese"]

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "list.dash").padding()
                Text("Grocery List")
                Spacer()
            }
            .font(Font.largeTitle.bold())
            Spacer()

            List(items, id: \.self, selection: $selectedItems) { item in
                Text(item)
            }
            .environment(\.editMode, .constant(.active))
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            Spacer()
        }
        .padding()
        // .bottomLine()
    }
}

#Preview {
    GroceryListView()
}

struct IngredientsView: View {
    @State private var selectedItems: Set<String> = []
    private let items = ["Bread", "Beef", "Butter"]

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "cabinet").padding()
                Text("Ingredients")
                Spacer()
            }
            .font(Font.largeTitle.bold())
            Spacer()

            List(items, id: \.self, selection: $selectedItems) { item in
                Text(item)
            }
            .environment(\.editMode, .constant(.active))
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            Spacer()
        }
        .padding()
        // .bottomLine()
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
        // .bottomLine()
    }
}

struct RecipesView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "bookmark").padding()
                Text("Recipe Library")
                Spacer()
            }
            .font(Font.largeTitle.bold())
            Spacer()
        }
        .padding()
        // .bottomLine()
    }
}

struct ScheduleView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "calendar").padding()
                Text("Schedule")
                Spacer()
            }
            .font(Font.largeTitle.bold())
            Spacer()
        }
        .padding()
        // .bottomLine()
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

