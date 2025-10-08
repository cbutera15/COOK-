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
            Image(systemName: "cabinet")
                .foregroundStyle(Color(hue: 0.1528, saturation: 3, brightness: 1))
                .padding()
            Text("Ingredients")
                .foregroundStyle(Color(hue: 0.1528, saturation: 3, brightness: 1))
            Spacer()
        }.font(Font.largeTitle.bold())
        Spacer()
    }
    .padding()
    .background(Color(hue: 0.1528, saturation: 0.04, brightness: 1))
//    .bottomLine()
  }
}

#Preview {
    IngredientsView()
}
