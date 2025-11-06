//
//  ScheduleView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

// Extending date to access day of week # (1, sunday -> 7, saturday)
extension Date {
    func getWeekdayNumber() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func withTime(hour: Int, minute: Int = 0, second: Int = 0) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.hour = hour
        components.minute = minute
        components.second = second
        return calendar.date(from: components) ?? self
    }
}

struct ScheduleView: View {
    // Calendar manager for EventKit
    @StateObject private var calendarManager = CalendarManager()
    
    // Global AppState Object
    @EnvironmentObject var appState: AppState
    
    // Defining private vars for recipes, days and times.
    @State private var showAddRecipe = false
    @State private var showDeleteButtons = false
    @State private var showEventsAddedAlert = false
    
    @State private var recipes: [Recipe] = [Recipe(name: "Recipe 1"), Recipe(name:"Recipe 2"), Recipe(name: "Recipe 3")]
    @State private var days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var times: [String] = ["Morning", "Afternoon", "Evening", "Snacks"]
    
    // Master schedule view schedule (TODO - change to get from Firebase)
    @State private var schedule = [Day(id: 0, name: "Monday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 1, name: "Tuesday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 2, name: "Wednesday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 3, name: "Thursday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 4, name: "Friday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 5, name: "Saturday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 6, name: "Sunday", morning: [], afternoon: [], evening: [], snacks: [])]
    
    @State var recipesHash: [String]
    @State var selectedRecipe: String
    @State var selectedDay: String
    @State var selectedTime: String
    
    
    var body: some View {
        let hasAnyRecipes = schedule.contains {
            !$0.morning.isEmpty || !$0.afternoon.isEmpty || !$0.evening.isEmpty || !$0.snacks.isEmpty
        }
        
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
                        Text(days[i]).font(.title).foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
                        
                        // Getting morning recipes
                        if !schedule[i].morning.isEmpty {
                            Text("Morning").font(.title2).foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                            ForEach(schedule[i].morning, id: \.name) { item in
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    if showDeleteButtons {
                                        Button(action: {
                                            if let idx = schedule[i].morning.firstIndex(where: { $0.name == item.name }) {
                                                schedule[i].morning.remove(at: idx)
                                            }
                                        }) {
                                            Image(systemName: "x.circle")
                                                .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                                                .transition(.move(edge: .leading).combined(with: .opacity))
                                        }
                                    }
                                }
                            }
                        }
                        // Getting afternoon recipes
                        if !schedule[i].afternoon.isEmpty {
                            Text("Afternoon").font(.title2).foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                            ForEach(schedule[i].afternoon, id: \.name) { item in
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    if showDeleteButtons {
                                        Button(action: {
                                            if let idx = schedule[i].afternoon.firstIndex(where: { $0.name == item.name }) {
                                                schedule[i].afternoon.remove(at: idx)
                                            }
                                        }) {
                                            Image(systemName: "x.circle")
                                                .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                                                .transition(.move(edge: .leading).combined(with: .opacity))
                                        }
                                    }
                                }
                            }
                        }
                        // Getting evening recipes
                        if !schedule[i].evening.isEmpty {
                            Text("Evening").font(.title2).foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                            ForEach(schedule[i].evening, id: \.name) { item in
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    if showDeleteButtons {
                                        Button(action: {
                                            if let idx = schedule[i].evening.firstIndex(where: { $0.name == item.name }) {
                                                schedule[i].evening.remove(at: idx)
                                            }
                                        }) {
                                            Image(systemName: "x.circle")
                                                .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                                                .transition(.move(edge: .leading))
                                        }
                                    }
                                }
                            }
                        }
                        // Getting snacks recipes
                        if !schedule[i].snacks.isEmpty {
                            Text("Snacks").font(.title2).foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                            ForEach(schedule[i].snacks, id: \.name) { item in
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    if showDeleteButtons {
                                        Button(action: {
                                            if let idx = schedule[i].snacks.firstIndex(where: { $0.name == item.name }) {
                                                schedule[i].snacks.remove(at: idx)
                                            }
                                        }) {
                                            Image(systemName: "x.circle")
                                                .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.5))
                                                .transition(.move(edge: .leading).combined(with: .opacity))
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
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
                    Task { await calendarManager.requestAccess() }
                    
                    let dayOfWeek = Date().getWeekdayNumber()
                    
                    // Calculate the date of Monday this week for Calendar event information
                    let monday = Calendar.current.date(byAdding: .day, value: 0 - Int(dayOfWeek! - 2), to: Date())
                    var dayIndex = monday!
                    
                    // Iterate over master schedule to calculate which day goes to which date.
                    for day in schedule {
                        for recipe in day.morning {
                            calendarManager.addEvent(title: recipe.name, startDate: dayIndex)
                            dayIndex = dayIndex.withTime(hour: 9)
                        }
                        for recipe in day.afternoon {
                            calendarManager.addEvent(title: recipe.name, startDate: dayIndex)
                            dayIndex = dayIndex.withTime(hour: 13)
                        }
                        for recipe in day.evening {
                            calendarManager.addEvent(title: recipe.name, startDate: dayIndex)
                            dayIndex = dayIndex.withTime(hour: 18)
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
                    Text("Add To Schedule")
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
                // Pop up sheet for adding recipes to shedule.
                .sheet(isPresented: $showAddRecipe) {
                    VStack {
                        Spacer()
                        Text("Add Recipe to Schedule")
                            .font(.title)
                            .padding()
                        Spacer()
                        
                        List {
                            Picker("Recipe", selection: $selectedRecipe) {
                                ForEach(recipes, id: \.name) { recipe in
                                    Text(recipe.name)
                                        .tag(recipe.name)
                                }
                            }
                            Picker("Day", selection: $selectedDay) {
                                ForEach(days, id: \.self) { day in
                                    Text(day)
                                        .tag(day)
                                }
                            }
                            Picker("Time", selection: $selectedTime) {
                                ForEach(times, id: \.self) { time in
                                    Text(time)
                                        .tag(time)
                                }
                            }
                        }
                        .listStyle(.plain)
                        Spacer()
                        
                        // Mapping to the correct recipe (recipe required to be Hashable to display in picker so had to create a seconday list to choose from. TODO - fix this? can recipe be Hashable?)
                        Button(action: {
                            showAddRecipe = false
                            for (index, day) in days.enumerated() {
                                if day == selectedDay {
                                    for recipe in recipes {
                                        if selectedRecipe == recipe.name {
                                            schedule[index].addRecipe(recipe: recipe, time: selectedTime)
                                        }
                                    }
                                }
                            }
                            
                        }) {
                            Text("Add")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        .tint(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
                        Spacer()
                    }.presentationDetents([.height(400)])
                }
            }
        }
        .padding()
        .background(Color(hue: 0.3389, saturation: 0.05, brightness: 1))
        .onAppear {
            recipesHash = recipes.map { $0.name }
            if let firstRecipe = recipesHash.first { selectedRecipe = firstRecipe }
            if let firstDay = days.first { selectedDay = firstDay }
            if let firstTime = times.first { selectedTime = firstTime }
        }
    }
}

#Preview {
    ScheduleView(recipesHash: [], selectedRecipe: "", selectedDay: "", selectedTime: "").environmentObject(AppState())
}

