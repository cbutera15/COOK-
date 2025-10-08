//
//  PlusView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

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

#Preview {
    PlusView()
}
