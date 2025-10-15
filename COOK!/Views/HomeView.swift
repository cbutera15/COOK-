//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(hue: 0.7444, saturation: 0.03, brightness: 0.99).ignoresSafeArea()
            VStack {
                Text("Upcoming Meals")
                Spacer()
                Text("Favorite Meals")
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    HomeView()
}
