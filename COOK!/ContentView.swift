//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//


import SwiftUI

struct HomeView: View {
  var body: some View {
    TabView {
      FirstView()
        .tabItem() {
          Image(systemName: "star")
        }
      SecondView()
        .tabItem() {
          Image(systemName: "sun.horizon")
        }
    }
  }
}

#Preview {
  HomeView()
}


struct FirstView: View {
  var body: some View {
      VStack {
        Image(systemName: "star.fill")
        Spacer().frame(width: 0, height: 50)
        Text("First View")
      }
      .padding()
      .bottomLine()
  }
}

#Preview {
  FirstView()
}


struct SecondView: View {
  var body: some View {
    VStack {
      Image(systemName: "sun.horizon")
      Spacer().frame(width: 0, height: 50)
      Text("Second View")
    }
    .padding()
    .bottomLine()
  }
}

#Preview {
  SecondView()
}

extension View {
  func bottomLine() -> some View {
    GeometryReader { geometry in
      self
        .frame(width: geometry.size.width, height: geometry.size.height).border(.black)
    }      .ignoresSafeArea(.all, edges: .top)
  }
}


