//
//  RecipeView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct RecipesView: View {
  var body: some View {
      VStack {
          HStack {
              Image(systemName: "bookmark.fill").padding()
              Text("Recipe Library")
              Spacer()
          }.font(Font.largeTitle.bold())
          Spacer()
          
          let recipes = ["Chicken and rice", "Pasta salad", "Spaghetti with meatballs"]
          NavigationStack {
              ForEach(recipes, id: \.self) { recipe in
                  NavigationLink(destination: RecipeView()) {
                      Text(recipe)
                  }
              }
          }
      }
      .padding()
      .bottomLine()
  }
}

#Preview {
    RecipesView()
}
