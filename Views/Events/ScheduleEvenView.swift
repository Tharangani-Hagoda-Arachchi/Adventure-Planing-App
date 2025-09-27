//
//  ScheduleEvenView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI

struct ScheduleEvenView: View {
    @StateObject private var viewModel = AdventurePlannerViewModel()
    @StateObject private var favViewModel = FavouriteViewModel()
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
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
                .foregroundColor(fontColor)
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
                    //to use same date
                        .onChange(of: breakfastTime) { newValue in
                             if manualBreakfast {
                                 let calendar = Calendar.current
                                 let timeComponents = calendar.dateComponents([.hour, .minute], from: newValue)
                                 if let updatedBreakfastTime = calendar.date(bySettingHour: timeComponents.hour ?? 0, minute: timeComponents.minute ?? 0, second: 0, of: startTime) {
                                     breakfastTime = updatedBreakfastTime
                                 }
                             }
                         }
                    
                    Toggle("Edit Lunch Time", isOn: $manualLunch)
                    DatePicker("Lunch", selection: $lunchTime, displayedComponents: [.hourAndMinute])
                        .disabled(!manualLunch)
                        .onChange(of: lunchTime) { newValue in
                            if manualLunch {
                                let calendar = Calendar.current
                                let timeComponents = calendar.dateComponents([.hour, .minute], from: newValue)
                                if let updatedLunchTime = calendar.date(bySettingHour: timeComponents.hour ?? 0, minute: timeComponents.minute ?? 0, second: 0, of: startTime) {
                                    lunchTime = updatedLunchTime
                                }
                            }
                        }
                    
                    Toggle("Edit Tea Time", isOn: $manualTea)
                    DatePicker("Tea", selection: $teaTime, displayedComponents: [.hourAndMinute])
                        .disabled(!manualTea)
                        .onChange(of: teaTime) { newValue in
                            if manualTea {
                                let calendar = Calendar.current
                                let timeComponents = calendar.dateComponents([.hour, .minute], from: newValue)
                                if let updatedTeaTime = calendar.date(bySettingHour: timeComponents.hour ?? 0, minute: timeComponents.minute ?? 0, second: 0, of: endTime) {
                                    teaTime = updatedTeaTime
                                }
                            }
                        }
                }
                
                Button("Add to Calendar") {
                    var event = AdventureEvent(
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
                    viewModel.addAdventureEvent(&event)
                    
                    //add to core data
                    favViewModel.addEvent(event: event)
                    
                    showNotificationOptions = true
                }
                .disabled(!viewModel.accessGranted)
                
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
        NavigationLink(destination: EventView(viewModel: favViewModel,adventurePlanerVModel: viewModel),isActive: $navigateToEvents) {
            EmptyView()
        }
        .sheet(isPresented: $showNotificationOptions){
            VStack(spacing:20){
                Text("Notify before adventure")
                    .font(.buttonLargeText)
                
                Picker("Minutes Before", selection: $notificationMinutes) {
                    Text("10 min").tag(10)
                    Text("30 min").tag(30)
                    Text("1 hour").tag(60)
                    Text("2 hours").tag(120)
                    Text("1 day").tag(1440)
                }
                .pickerStyle(PalettePickerStyle())
                
                Button("Confirm") {
                    if let lastEvent = viewModel.adventureEvents.last {
                        viewModel.scheduleNotification(for: lastEvent, minutesBefore: notificationMinutes)
                    }
                    showNotificationOptions = false
                    navigateToEvents = true
                }.padding()
                
            }.padding()
                .presentationDetents([.medium])
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
    //dark mode color change
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
}




