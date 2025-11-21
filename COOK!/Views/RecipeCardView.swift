//
//  RecipeCardView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 11/19/25.
//

import SwiftUI

struct RecipeCardView: View {
    @EnvironmentObject var appState: AppState
    
    @Binding var day: Day
    @Binding var recipe: Recipe
    @Binding var showAddRecipe: Bool
    @Binding var selectedDay: String
    
    @State private var selected: [Ingredient] = []
    
    var color: Color
    var buttonColor: Color
    var showDelete: Bool
    
    let width: CGFloat = 150
    let height: CGFloat = 100
    
    var textOverlay: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(recipe.name)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.horizontal)
                    .background(
                        Rectangle()
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .cornerRadius(6)
                    )
            }
        }
        .cornerRadius(10)
        .padding()
    }
    
    var body: some View {
        if recipe.name == "" {
            Rectangle()
                .foregroundStyle(color)
                .scaledToFill()
                .frame(width: width, height: height)
                .cornerRadius(10)
                .overlay(alignment: .center, content: {
                    VStack {
                        Image(systemName: "plus")
                        Text("Add meal")
                            .bold()
                            .padding()
                    }
                })
                .onTapGesture {
                    showAddRecipe = !showAddRecipe
                    selectedDay = day.name
                }
        } else {
            ZStack(alignment: .topTrailing) {
                NavigationLink(destination: RecipeView(recipe: $recipe, selected: $selected)) {
                    if let image = recipe.imagePath {
                        recipe.imagePath?
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: height)
                            .cornerRadius(10)
                            .overlay(textOverlay)
                    } else {
                        Rectangle()
                            .foregroundStyle(color)
                            .frame(width: width, height: height)
                            .cornerRadius(10)
                            .overlay(textOverlay)
                    }
                }
                .contentShape(Rectangle())
                .frame(width: width, height: height)
                .buttonStyle(.plain)
                
                if showDelete {
                    Button(action: {
                        appState.deleteMealFromSchedule(day, recipe)
                    }) {
                        Image(systemName: "x.square.fill")
                            .font(Font.title.bold())
                            .foregroundColor(buttonColor)
                            .padding(6)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                    .zIndex(1)
                }
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
    @State var selectedDay: String = "Tuesday"
    
    @State var showAddRecipe: Bool = false
    
    RecipeCardView(
        day: $day,
        recipe: $chickenAndRice,
        showAddRecipe: $showAddRecipe,
        selectedDay: $selectedDay,
        color: .gray,
        buttonColor: .red,
        showDelete: true
    ).environmentObject(AppState())
}
