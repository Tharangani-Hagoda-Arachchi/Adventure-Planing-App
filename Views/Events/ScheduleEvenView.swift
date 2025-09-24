//
//  ScheduleEvenView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI

struct ScheduleEvenView: View {
    @StateObject private var viewModel = AdventurePlannerViewModel()
    
    @State var adventureName: String
    @State private var location = ""
    
    @State private var startTime = Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!
    @State private var endTime = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!
    
    @State private var breakfastTime = Date()
    @State private var lunchTime = Date()
    @State private var teaTime = Date()
    
    @State private var manualBreakfast = false
    @State private var manualLunch = false
    @State private var manualTea = false
    
    @State private var navigateToEvents = false
    @State private var showNotificationOptions = false
    @State private var notificationMinutes = 60
    
    var body: some View {
        NavigationStack{
            
            TopNavigationView()
            
            Text("Shedule Adventure")
                .font(Font.buttonLargeText)
                .foregroundColor(Color.AppPrimaryTextField)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,20)
            
            Form {
                Section(header: Text("Adventure Details")) {
                    TextField("Title", text: $adventureName)
                    TextField("Location", text: $location)
                    
                    DatePicker("Start Time", selection: $startTime, displayedComponents: [.date, .hourAndMinute])
                        .onChange(of: startTime) { _ in
                            updateMealTimes()
                        }
                    
                    DatePicker("End Time", selection: $endTime, displayedComponents: [.date, .hourAndMinute])
                        .onChange(of: endTime) { _ in
                            updateMealTimes()
                        }
                }
                
                Section(header: Text("Meals")) {
                    Toggle("Edit Breakfast Time", isOn: $manualBreakfast)
                    DatePicker("Breakfast", selection: $breakfastTime, displayedComponents: [.hourAndMinute])
                        .disabled(!manualBreakfast)
                    
                    Toggle("Edit Lunch Time", isOn: $manualLunch)
                    DatePicker("Lunch", selection: $lunchTime, displayedComponents: [.hourAndMinute])
                        .disabled(!manualLunch)
                    
                    Toggle("Edit Tea Time", isOn: $manualTea)
                    DatePicker("Tea", selection: $teaTime, displayedComponents: [.hourAndMinute])
                        .disabled(!manualTea)
                }
                
                Button("Add to Calendar") {
                    let event = AdventureEvent(
                        title: adventureName,
                        location: location,
                        startDateTime: startTime,
                        endDateTime: endTime,
                        breakfastTime: breakfastTime,
                        lunchTime: lunchTime,
                        teaTime: teaTime,
                        manualBreakfast: manualBreakfast,
                        manualLunch: manualLunch,
                        manualTea: manualTea
                    )
                    viewModel.addAdventureEvent(event)
                    showNotificationOptions = true
                }
                .disabled(!viewModel.accessGranted)
                
            }
        }
        NavigationLink(destination: EventView(viewModel: viewModel), isActive: $navigateToEvents) { EmptyView()
        }
        .sheet(isPresented: $showNotificationOptions){
            VStack(spacing:20){
                Text("Notify before adventie")
                    .font(.buttonLargeText)
                
                Picker("Minutes Before", selection: $notificationMinutes) {
                    Text("10 min").tag(10)
                    Text("30 min").tag(30)
                    Text("1 hour").tag(60)
                    Text("2 hours").tag(120)
                    Text("1 day").tag(1440)
                }
                .pickerStyle(WheelPickerStyle())
                
                Button("Confirm") {
                    if let lastEvent = viewModel.adventureEvents.last {
                        viewModel.scheduleNotification(for: lastEvent, minutesBefore: notificationMinutes)
                    }
                    showNotificationOptions = false
                    navigateToEvents = true
                }.padding()
                
            }.padding()
        }
        
        .onAppear {
            viewModel.requestAccess()
            viewModel.requestNotificationAccess()
            updateMealTimes()
        }
        .navigationBarHidden(true)
        .alert(item: $viewModel.alertMessage) { alertMessage in
            Alert(title: Text("Infomation"), message: Text(alertMessage.message), dismissButton: .default(Text("OK")))
        }
    }
        
    
       
 
private func updateMealTimes() {
    if !manualBreakfast {
        breakfastTime = Calendar.current.date(byAdding: .hour, value: -1, to: startTime)!
    }
    if !manualLunch {
        lunchTime = startTime.addingTimeInterval((endTime.timeIntervalSince(startTime)) / 2)
    }
    if !manualTea {
        teaTime = Calendar.current.date(byAdding: .hour, value: -1, to: endTime)!
    }
}
    
}




