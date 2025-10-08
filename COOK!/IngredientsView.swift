//
//  IngredientsView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct IngredientsView: View {
  var body: some View {
    VStack {
        HStack {
            Image(systemName: "cabinet").padding()
            Text("Ingredients")
            Spacer()
        }.font(Font.largeTitle.bold())
        Spacer()
    }
    .padding()
//    .bottomLine()
  }
}

#Preview {
    IngredientsView()
}
