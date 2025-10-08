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
      }
      .padding()
//    .bottomLine()
  }
}

#Preview {
    RecipesView()
}
