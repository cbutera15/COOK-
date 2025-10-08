//
//  ScheduleView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/7/25.
//

import SwiftUI

struct ScheduleView: View {
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
      }
      .padding()
<<<<<<< HEAD:COOK!/ScheduleView.swift
      .background(Color(hue: 0.3389, saturation: 0.05, brightness: 1))
//    .bottomLine()
=======
      .bottomLine()
>>>>>>> main:COOK!/Views/ScheduleView.swift
  }
}

#Preview {
    ScheduleView()
}
