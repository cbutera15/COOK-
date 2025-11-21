//
//  ScheduleView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

// TODO - Scrollable Cards

import SwiftUI
internal import EventKit

struct ScheduleView: View {
    // Calendar manager for EventKit
    @StateObject private var calendarManager = CalendarManager()
    
    // Global AppState Object
    @EnvironmentObject var appState: AppState
    
    // Defining private vars for recipes, days and times.
    @State private var showAddRecipe = false
    @State private var showDeleteButtons = false
    @State private var showEventsAddedAlert = false
    @State private var newRecipe = Recipe(name: "", ingredients: [], instructions: "")
    
    @State private var days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var times: [String] = ["Morning", "Afternoon", "Evening", "Snacks"]
    
    @State var recipesHash: [String]
    @State var selectedRecipe: String
    @State var selectedDay: String
    
    var body: some View {
        let hasAnyRecipes = appState.schedule.contains {
            !$0.meals.isEmpty
        }
        
        NavigationStack {
            VStack(alignment: .leading) {
                
                // Heading
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
                        .padding()
                        .font(Font.largeTitle.bold())
                    Text("Schedule")
                        .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
                        .font(Font.largeTitle.bold())
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showDeleteButtons.toggle()
                        }
                    }) {
                        Text("Edit")
                    }
                    .padding()
                    .buttonStyle(.bordered)
                    .tint(Color(hue: 0.3389, saturation: 1, brightness: 0.65))
                    .disabled(!hasAnyRecipes)
                    
                }
                Spacer()
                
                
                // Main Schedule View
                ScrollView {
                    VStack(alignment: .leading) {
                        // Iterate through day list
                        ForEach(0..<days.count, id: \.self) { i in
                            let dayBinding: Binding<Day> = $appState.schedule[i]
                            
                            DayView(
                                day: dayBinding,
                                showAddRecipe: $showAddRecipe,
                                selectedDay: $selectedDay,
                                color: Color(hue: 0.3389, saturation: 0.2, brightness: 0.9),
                                buttonColor: Color(hue: 0.3389, saturation: 0.05, brightness: 0.95),
                                showDelete: showDeleteButtons
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
              
                Spacer()
                
                // Add Calendar and Schedule buttons
                HStack {
                    // Add to calendar button (uses EventKit)
                    Button(action: {
                        // Request write only access to user's calendar
                        Task { @MainActor in
                            await calendarManager.requestAccess()
                            // Then call addEvent only if authorized
                            if calendarManager.authorizationStatus == .writeOnly {
                                calendarManager.addEvent(title: "Test", startDate: Date())
                            } else {
                                print("User did not grant calendar write access.")
                            }
                        }
                        
                        let dayOfWeek = Date().getWeekdayNumber()
                        
                        // Calculate the date of Monday this week for Calendar event information
                        let monday = Calendar.current.date(byAdding: .day, value: 0 - Int(dayOfWeek! - 2), to: Date())
                        var dayIndex = monday!
                        
                        // Iterate over master schedule to calculate which day goes to which date.
                        for day in appState.schedule {
                            for recipe in day.meals {
                                calendarManager.addEvent(title: recipe.name, startDate: dayIndex)
                                dayIndex = dayIndex.withTime(hour: 9)
                            }
                            dayIndex = Calendar.current.date(byAdding: .day, value: 1, to: dayIndex)!
                         }
                        showEventsAddedAlert = true
                    }) {
                        Text("Export to Calendar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .tint(Color(hue: 0.3389, saturation: 1, brightness: 0.65))
                    .alert("Added to Calendar", isPresented: $showEventsAddedAlert) {
                        
                    } message: {
                        Text("Recipes added to default device calendar.")
                    }
                    
                    // Add to schedule button
                    Button(action: {
                        showAddRecipe = true
                    }) {
                        Text("Add From Scratch")
                            .frame(maxWidth: .infinity)
                        
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
                    // Pop up sheet for adding recipes to shedule.
                    .sheet(isPresented: $showAddRecipe) {
                        // FIX
                        
                        EditRecipeView(recipe: $newRecipe, addRecipe: true, showDay: true, selectedDay: "Monday")
                    }
                }
            }
            .padding()
            .background(Color(hue: 0.3389, saturation: 0.05, brightness: 1))
            .onAppear {
                recipesHash = appState.savedRecipes.map { $0.name }
                if let firstRecipe = recipesHash.first { selectedRecipe = firstRecipe }
                if let firstDay = days.first { selectedDay = firstDay }
            }
        }
    }
}

#Preview {
    ScheduleView(recipesHash: [], selectedRecipe: "", selectedDay: "").environmentObject(AppState())
}

