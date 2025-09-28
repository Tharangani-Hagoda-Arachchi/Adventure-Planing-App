//
//  EventView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import SwiftUI

struct EventView: View {
    @StateObject  var viewModel: FavouriteViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject  var adventurePlanerVModel: AdventurePlannerViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            HStack{

                TopNavigationView(showBackButton: true)
            }
       
            
            Text("Scheduled Adventures")
                .font(Font.buttonLargeText)
                .foregroundColor(fontColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,20)
            
            List {
                if viewModel.event.isEmpty {
                    Text("No scheduled adventures")
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.event, id: \.id) { event in
                        HStack(spacing: 12){
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                                .foregroundColor(.AppPrimary)
                                .padding(6)
                                .background(Circle().fill(Color(.systemGray6)))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(event.title ?? "Untitle")
                                    .font(.headline)
                                if let location = event.location {
                                    Text(location)
                                        .font(.cardTitleText)
                                        .foregroundColor(.secondary)
                                }
                                if let start = event.startDateTime,
                                   let end = event.endDateTime {
                                    Text("\(start.formatted(date: .abbreviated, time: .shortened)) - \(end.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.cardText)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }.padding(.vertical,8)

                    }
                    .onDelete { indexSet in
                        indexSet.forEach { idx in
                            let event = viewModel.event[idx]
                            if let id = event.id {
                                viewModel.removeEvent(planId: id, adventurePlanerVModel: adventurePlanerVModel)
                            }
                        }
                    }
                }
            }
            
            
            
        }.preferredColorScheme(isDarkMode ? .dark : .light)
        .navigationBarHidden(true)
        .toolbar { EditButton() }
        .onAppear {
            viewModel.loadEvent()
            adventurePlanerVModel.requestAccess()
            adventurePlanerVModel.requestNotificationAccess()
        }
        
    }
    
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
}


