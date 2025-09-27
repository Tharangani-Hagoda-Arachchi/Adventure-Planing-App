//
//  AdventurePlannerViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI
import Foundation
import EventKit
import UserNotifications

struct AlertMessage: Identifiable {
    let id = UUID()
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}

class AdventurePlannerViewModel: ObservableObject {
    
    @Published var adventureEvents :[AdventureEvent] = []
    
    private let eventStore = EKEventStore()
    
    @Published var accessGranted = false
    @Published var notificationAccessGranted = false
    @Published var alertMessage: AlertMessage? = nil
    
    
    
    //request permision for calander
    func requestAccess() {
        eventStore.requestAccess(to: .event) { granted, error in
            DispatchQueue.main.async {
                self.accessGranted = granted
                if let error = error {
                    self.alertMessage = AlertMessage("Permission error: \(error.localizedDescription)")
                } else if !granted {
                    self.alertMessage = AlertMessage ("Calendar access was denied.")
                }
            }
        }
    }
    
    //request permision for notification
    func requestNotificationAccess(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ granted, error in
            DispatchQueue.main.async {
                self.notificationAccessGranted = granted
                if let error = error {
                    self.alertMessage = AlertMessage("Notification pemision error:  \(error.localizedDescription)")
                } else if !granted {
                    self.alertMessage = AlertMessage ("Notification access was denied.")
                }
            }
        }
    }
    
    
    
    func addAdventureEvent(_ event: inout AdventureEvent ) {
        guard accessGranted else {
            alertMessage = AlertMessage("Calendar access not granted.")
            return
        }
        
        
        // Save main even
        if let calendarId = saveEvent(
            title: event.title,
            location: event.location,
            notes: "Main Adventure",
            start: event.startDateTime,
            end: event.endDateTime) {
            event.calendarId = calendarId
        }
        
        adventureEvents.append(event)
        
        
        
        // Breakfast
        let breakfastEnd = Calendar.current.date(
            byAdding: .minute,
            value: 30,
            to: event.breakfastTime
        )!
        saveEvent(
            title: "Breakfast",
            location: "Before starting",
            notes: "Quick meal before trip",
            start: event.breakfastTime,
            end: event.startDateTime
        )
        
        // Lunch
        let lunchEnd = Calendar.current.date(
            byAdding: .minute, value: 45,
            to: event.lunchTime
        )!
        saveEvent(
            title: "Lunch",
            location: event.location,
            notes: "During adventure",
            start: event.lunchTime,
            end: lunchEnd
        )
        
        // Tea
        let teaEnd = Calendar.current.date(
            byAdding: .minute,
            value: 30, to:
                event.teaTime
        )!
        saveEvent(
            title: "Tea",
            location: event.location,
            notes: "Wrap-up break",
            start: event.teaTime,
            end: teaEnd
        )
        
        alertMessage = AlertMessage("Adventure + Meals added to Calendar!")
    }
    
    
    private func saveEvent(title: String, location: String, notes: String, start: Date, end: Date) -> String? {
        let newEvent = EKEvent(eventStore: eventStore)
        newEvent.title = title
        newEvent.location = location
        newEvent.notes = notes
        newEvent.startDate = start
        newEvent.endDate = end
        newEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(newEvent, span: .thisEvent)
            return newEvent.calendarItemIdentifier
        } catch {
            print("Error saving event \(title): \(error.localizedDescription)")
            return nil
            
        }
    }
    
    
    func deleteEventFromCalendar(event: AdventureEvent) {
        guard let calendarId = event.calendarId else {
            print("No calendar ID saved for this event")
            return
        }
        
        if let calendarId = event.calendarId{
            if let ekEvent = eventStore.event(withIdentifier: calendarId){
                do{
                    try eventStore.remove(ekEvent, span: .thisEvent)
                    print("main event deletion in calendar successfull")
                }catch{
                    print(" fail main event deletion in calendar ")
                }
            }else{
                print(" main event not found for this calendar id")
            }
        }
        if let ekEvent = eventStore.event(withIdentifier: calendarId){
            do{
                try eventStore.remove(ekEvent, span: .thisEvent)
                print("main event deletion in calendar successfull")
            }catch{
                print(" fail main event deletion in calendar ")
                //fallback function
                deleteMainEventByTitleAndDate(event: event)
            }
        }else{
            print(" main event not found for this calendar id")
        }
        
        deleteMealEvents(for: event)
        
        
    }
    
    //fallback function to delete main event using title and date(if fail deletion using calendar id the this function call)
    private func deleteMainEventByTitleAndDate(event: AdventureEvent){
        let startDate = Calendar.current.startOfDay(for: event.startDateTime)
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let events = eventStore.events(matching: predicate)
        
        for ekEvent in events {
            if ekEvent.title == event.title &&
                abs(ekEvent.startDate.timeIntervalSince(event.startDateTime)) < 60 {
                do {
                    try eventStore.remove(ekEvent, span: .thisEvent)
                    print("Successfully deleted main event: \(ekEvent.title ?? "")")
                } catch {
                    print("Failed to delete main event: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    
    private func deleteMealEvents(for event: AdventureEvent){
        
        let startDate = Calendar.current.startOfDay(for: event.startDateTime)
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let events = eventStore.events(matching: predicate)
        
        let mealTitles = [
            "Breakfast - \(event.title)",
            "Lunch - \(event.title)",
            "Tea - \(event.title)"
        ]
        
        for ekEvent in events{
            do{
                try eventStore.remove(ekEvent, span: .thisEvent)
                print("meal event deletion in calendar successfull")
            }catch{
                print(" fail meal event deletion in calendar ")
            }
        }
    }
    
    // delete event
    func deleteEvent(event: AdventureEvent){
        
        adventureEvents.removeAll {$0.id == event.id}
        
        deleteEventFromCalendar(event: event)
        
        let ids = [
            event.id.uuidString,
            event.id.uuidString + "_breakfast",
            event.id.uuidString + "_lunch",
            event.id.uuidString + "_tea"
            
        ]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
        
        print("complete event deletion successful")
        
        
        
    }
    
    func scheduleNotification(for event: AdventureEvent, minutesBefore: Int){
        
        guard notificationAccessGranted else {
            alertMessage = AlertMessage("Notifications not allowed.")
            return
        }
        
        //before start adventure notification
        scheduleNotification(
            title: "Adventure Reminder",
            body: "Your adventure \"\(event.title)\" at \(event.location) starts soon",
            id: event.id.uuidString,
            date: Calendar.current.date(byAdding: .minute, value: -minutesBefore, to: event.startDateTime)
        )
        
        // for breakfast
        if event.manualBreakfast || true {
            scheduleNotification(
                title: "Breakfast Time",
                body: "Time for breakfast during \"\(event.title)\" adventure.",
                id: event.id.uuidString + "_breakfast",
                date: event.breakfastTime
            )
            
        }
        
        // for lunch
        if event.manualLunch || true {
            scheduleNotification(
                title: "Lunch Time",
                body: "Time for lunch during \"\(event.title)\" adventure.",
                id: event.id.uuidString + "_lunch",
                date: event.lunchTime
            )
            
        }
        
        if event.manualTea || true {
            scheduleNotification(
                title: "Tea Time",
                body: "Time for Tea during \"\(event.title)\" adventure.",
                id: event.id.uuidString + "_tea",
                date: event.teaTime
            )
        }
        
        
    }
    
    
    //  to cteate notification
    private func scheduleNotification(title: String, body: String, id: String, date: Date?){
        guard let date = date else { return }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents( [.year, .month, .day, .hour, .minute], from: date ),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = AlertMessage("Failed to schedule notification: \(error.localizedDescription)")
                }
            }
        }
    }
    

    
}

