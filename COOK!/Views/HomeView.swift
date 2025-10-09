//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//


import SwiftUI

struct HomeView: View {
  var body: some View {
      VStack {
          Text("Upcoming Meals")
          Spacer()
          Text("Favorite Meals")
          Spacer()
      }
      .padding()
      .bottomLine()
  }
}


#Preview {
  HomeView()
}

