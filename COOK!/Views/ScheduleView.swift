// ... existing code ...

} message {
    Text("Events added is ", count: calendarManager.events.count)
}

if let eventCount = calendarManager.events.count && eventCount < 10 {
    showEventsAddedAlert = true
}.alert("Only \(eventCount) test events added to calendar") {
    
}
