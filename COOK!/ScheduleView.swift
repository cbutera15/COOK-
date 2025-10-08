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
              Image(systemName: "calendar").padding()
              Text("Schedule")
              Spacer()
          }.font(Font.largeTitle.bold())
          Spacer()
      }
      .padding()
//    .bottomLine()
  }
}

#Preview {
    ScheduleView()
}
