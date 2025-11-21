//
//  CalendarManager.swift
//  COOK!
//
//  Created by Colin Butera on 10/29/25.
//

import SwiftUI
internal import EventKit
import EventKitUI
import Combine


@MainActor class CalendarManager: ObservableObject {
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
    
    // TODO: fix timing
    func addEvent(title: String, startDate: Date) {
        // Ensure we have write access
        guard authorizationStatus == .writeOnly else {
            print("Cannot add event: no calendar write access.")
            return
        }

        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = Calendar.current.date(byAdding: .minute, value: 30, to: startDate)

        // Safely pick a calendar
        if let defaultCal = eventStore.defaultCalendarForNewEvents, defaultCal.allowsContentModifications {
            event.calendar = defaultCal
        } else {
            let writableCalendars = eventStore.calendars(for: .event).filter { $0.allowsContentModifications }
            guard let cal = writableCalendars.first else {
                print("No writable calendars available.")
                return
            }
            event.calendar = cal
        }

        do {
            try eventStore.save(event, span: .thisEvent)
            print("Event saved successfully.")
        } catch {
            print("Error saving event: \(error)")
        }
    }
}
