//
//  DayView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 11/19/25.
//

import SwiftUI

struct DayView: View {
    @Binding var day: Day
    @Binding var showAddRecipe: Bool
    @Binding var selectedDay: String
    
    var color: Color
    var buttonColor: Color
    var showDelete: Bool
    
    @State private var newRecipe = Recipe()
    
    
    var body: some View {
        Text(day.name).font(.title).foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
        
        ScrollView(.horizontal) {
            HStack {
                ForEach($day.meals) { $meal in
                    RecipeCardView(
                        day: $day,
                        recipe: $meal,
                        showAddRecipe: $showAddRecipe,
                        selectedDay: $selectedDay,
                        color: .gray,
                        buttonColor: buttonColor,
                        showDelete: showDelete
                    )
                }
                
                RecipeCardView(
                    day: $day,
                    recipe: $newRecipe,
                    showAddRecipe: $showAddRecipe,
                    selectedDay: $selectedDay,
                    color: .gray,
                    buttonColor: buttonColor,
                    showDelete: false
                )
            }
        }
    }
}

#Preview {
    var chicken: Ingredient = Ingredient(name: "Chicken breast", quantity: 2)
    var rice: Ingredient = Ingredient(name: "Rice", quantity: 1)
    @State var chickenAndRice = Recipe(
        name: "Chicken and Rice",
        imagePath: Image(systemName: "photo"),
        ingredients: [chicken, rice]
    )
    @State var day = Day(id: 0, name: "Tuesday", meals: [chickenAndRice])
    @State var showAddRecipe: Bool = false
    @State var selectedDay: String = "Tuesday"
    
    DayView(
        day: $day,
        showAddRecipe: $showAddRecipe,
        selectedDay: $selectedDay,
        color: .gray,
        buttonColor: .red,
        showDelete: true)
}
