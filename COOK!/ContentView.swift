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
      PlusView()
        .tabItem() {
          Image(systemName: "plus")
        }
      ThirdView()
        .tabItem {
          Image(systemName: "paperclip")
        }
      FourthView()
        .tabItem {
          Image(systemName: "person.fill")
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


struct PlusView: View {
  var body: some View {
    VStack {
      Image(systemName: "plus")
      Spacer().frame(width: 0, height: 50)
      Text("Third View")
    }
    .padding()
    .bottomLine()
  }
}

struct ThirdView: View {
  var body: some View {
    VStack {
      Image(systemName: "paperclip")
      Spacer().frame(width: 0, height: 50)
      Text("Third View")
    }
    .padding()
    .bottomLine()
  }
}

struct FourthView: View {
  var body: some View {
    VStack {
      Image(systemName: "person.fill")
      Spacer().frame(width: 0, height: 50)
      Text("Fourth View")
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


