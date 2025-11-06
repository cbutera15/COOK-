//
//  PlusView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct PlusView: View {
    @EnvironmentObject var appState: AppState
    
  var body: some View {
    VStack {
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
//    .padding()
    .background(appState.backgroundColor)
  }
}

#Preview {
    PlusView().environmentObject(AppState())
}
