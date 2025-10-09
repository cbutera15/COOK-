//
//  RecipeView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        VStack {
            Text("Recipe Title")
            Spacer()
            Text("Image")
            Spacer()
            Text("Ingredients")
            Spacer()
            Text("Instructions")
        }
        .padding()
        .bottomLine()
    }
}

#Preview {
    RecipeView()
}
