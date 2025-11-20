//
//  ContentView.swift
//  COOK!
//
//  Created by Alexa Witkin on 10/7/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    // TODO replace today with actual calculation of today and pull info from appState.schedule
    @State var today: Day = Day(
        id: 0,
        name: "Monday",
        meals: [
            Recipe(name: "Chicken and rice"),
            Recipe(name: "Pasta salad")
        ]
    )
    @State var showAddRecipe: Bool = false
    @State var selectedDay: String = ""
    
    var body: some View {
        VStack {
            Text("Upcoming Meals")
            DayView(
                day: $today,
                showAddRecipe: $showAddRecipe,
                selectedDay: $selectedDay,
                color: .gray,
                buttonColor: .white,
                showDelete: false
            )
            Spacer()
            Text("Favorite Meals")
            Spacer()
        }
        .padding(.horizontal)
        .background(appState.backgroundColor)
    }
}


#Preview {
    HomeView().environmentObject(AppState())
}
