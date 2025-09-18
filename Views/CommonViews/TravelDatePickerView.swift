//
//  TravelDatePickerView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import SwiftUI

struct TravelDatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var travellers: Int
    
    let travelRange = 1...20
    
    var body: some View {
        HStack(spacing: 0){
            //date picker
            VStack(alignment: .leading, spacing: 4){
                Text("Date")
                    .font(.cardSubTitleText)
                    .foregroundColor(Color.AppPrimaryTextField)
                
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Divider()
                .frame(height: 40)
            
            // no of travelles picker
            VStack(alignment: .leading, spacing: 4){
                Text("Travelles")
                    .font(.cardSubTitleText)
                    .foregroundColor(Color.AppPrimaryTextField)
                
                Picker("Travellers", selection: $travellers) {
                    ForEach(travelRange, id: \.self) { num in
                        Text("\(num)")
                    }
                }
                .pickerStyle(.menu)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.AppPrimary.opacity(0.4), lineWidth: 1)
        )
    }
}


