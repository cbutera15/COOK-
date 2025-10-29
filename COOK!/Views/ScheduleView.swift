//
//  ScheduleView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct ScheduleView: View {
    @State private var showAddRecipe = false
    @State private var recipes: [Recipe] = [Recipe(name: "Recipe 1"), Recipe(name:"Recipe 2"), Recipe(name: "Recipe 3")]
    @State private var days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var times: [String] = ["Morning", "Afternoon", "Evening", "Snack"]
    
    @State private var schedule = [Day(id: 0, name: "Monday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 1, name: "Tuesday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 2, name: "Wednesday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 3, name: "Thursday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 4, name: "Friday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 5, name: "Saturday", morning: [], afternoon: [], evening: [], snacks: []), Day(id: 6, name: "Sunday", morning: [], afternoon: [], evening: [], snacks: [])]
    
    @State var recipesHash: [String]
    @State var selectedRecipe: String
    @State var selectedDay: String
    @State var selectedTime: String
    
    var body: some View {
      VStack {
          HStack {
              Image(systemName: "calendar")
                  .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
                  .padding()
              Text("Schedule")
                  .foregroundStyle(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
              Spacer()
          }.font(Font.largeTitle.bold())
          Spacer()
          
          ForEach(days.indices, id: \.self) { i in
              Text(days[i]).font(.title)
              if !schedule[i].morning.isEmpty {
                  Text("Morning").font(.title2)
                  ForEach(schedule[i].morning, id: \.name) { item in
                      Text(item.name)
                  }
              }
              if !schedule[i].afternoon.isEmpty {
                  Text("Afternoon").font(.title2)
                  ForEach(schedule[i].afternoon, id: \.name) { item in
                      Text(item.name)
                  }
              }
              if !schedule[i].evening.isEmpty {
                  Text("Evening").font(.title2)
                  ForEach(schedule[i].evening, id: \.name) { item in
                      Text(item.name)
                  }
              }
              if !schedule[i].snacks.isEmpty {
                  Text("Snacks").font(.title2)
                  ForEach(schedule[i].snacks, id: \.name) { item in
                      Text(item.name)
                  }
              }
          }
          
          
//          Text("Monday").font(.title)
//          if !schedule[0].morning.isEmpty {
//              Text("Morning").font(.title2)
//              Text(schedule[0].morning[0].name)
//          }
//          Text("Tuesday").font(.title)
//          if !schedule[1].morning.isEmpty {
//              Text(schedule[1].morning[0].name)
//          }
//          Text("Wednesday").font(.title)
//          if !schedule[2].morning.isEmpty {
//              Text(schedule[2].morning[0].name)
//          }
//          Text("Thursday").font(.title)
//          if !schedule[3].morning.isEmpty {
//              Text(schedule[3].morning[0].name)
//          }
//          Text("Friday").font(.title)
//          if !schedule[4].morning.isEmpty {
//              Text(schedule[4].morning[0].name)
//          }
//          Text("Saturday").font(.title)
//          if !schedule[5].morning.isEmpty {
//              Text(schedule[5].morning[0].name)
//          }
//          Text("Sunday").font(.title)
//          if !schedule[6].morning.isEmpty {
//              Text(schedule[6].morning[0].name)
//          }
          
          Spacer()
          
          Button(action: {
              showAddRecipe = true}
          ) {
              Text("Add To Schedule")
                  .frame(maxWidth: .infinity)
              
          }
          .buttonStyle(BorderedProminentButtonStyle())
          .tint(Color(hue: 0.3389, saturation: 1, brightness: 0.85))
          .padding()
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
//                  .frame(maxHeight: 100)
                  .listStyle(.plain)
                  Spacer()
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
          .onAppear() {
              for recipe in recipes {
                  recipesHash.append(recipe.name)
              }
              selectedRecipe = recipesHash[0]
              selectedDay = days[0]
              selectedTime = times[0]
          }
          Spacer()
              
      }
      .padding()
      .background(Color(hue: 0.3389, saturation: 0.05, brightness: 1))
  }
}

#Preview {
    ScheduleView(recipesHash: [], selectedRecipe: "", selectedDay: "", selectedTime: "")
}
