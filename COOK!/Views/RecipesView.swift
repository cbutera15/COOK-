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
              Image(systemName: "bookmark.fill")
                  .foregroundStyle(Color(hue: 0.5611, saturation: 0.88, brightness: 1))
                  .padding()
              Text("Recipe Library")
                  .foregroundStyle(Color(hue: 0.5611, saturation: 0.88, brightness: 1))
              Spacer()
          }.font(Font.largeTitle.bold())
          Spacer()
      }
      .padding()
      .background(Color(hue: 0.5611, saturation: 0.05, brightness: 1))
  }
}

#Preview {
    RecipesView()
}
