//
//  EventView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import SwiftUI

struct EventView: View {
    @ObservedObject var viewModel: AdventurePlannerViewModel
    
    var body: some View {
        VStack{
            //top navigation view
            TopNavigationView()
            
            Text("Sheduled Adventures")
                .font(Font.buttonLargeText)
                .foregroundColor(Color.AppPrimaryTextField)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,20)
            
            List {
                        if viewModel.adventureEvents.isEmpty {
                            Text("No scheduled adventures")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(viewModel.adventureEvents) { event in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(event.title).font(.headline)
                                    Text(event.location).font(.subheadline).foregroundColor(.secondary)
                                    Text("\(event.startDateTime.formatted(date: .abbreviated, time: .shortened)) - \(event.endDateTime.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { idx in
                                    let event = viewModel.adventureEvents[idx]
                                    viewModel.deleteEvent(event)
                                }
                            }
                        }
                    }


            
        }

        .navigationBarHidden(true)
                .toolbar { EditButton() }
    }
}


