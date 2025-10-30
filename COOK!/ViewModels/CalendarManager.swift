//
//  CalendarManager.swift
//  COOK!
//
//  Created by Colin Butera on 10/29/25.
//

import SwiftUI
import EventKit
import EventKitUI
import Combine


class CalendarManager: ObservableObject {
    let eventStore = EKEventStore()
    @Published var calendar: EKCalendar? = nil
    @Published var authorizationStatus: EKAuthorizationStatus = .notDetermined
    
    func requestAccess() async {
        do {
            let decision = try await eventStore.requestWriteOnlyAccessToEvents()
            if decision {
                authorizationStatus = .writeOnly
            } else {
                authorizationStatus = .denied
            }
        } catch {
            print("Error requesting Calendar Write Access: \(error)")
        }
    }
    
    func addEvent(title: String, startDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = Calendar.current.date(byAdding: .minute, value: 30, to: startDate)!
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            print("Event saved successfully.")
        } catch {
            print("Error saving event: \(error)")
        }
    }
}
