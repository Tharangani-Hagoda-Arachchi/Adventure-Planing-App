//
//  TravelDatePickerView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import SwiftUI

struct TravelDatePickerView: View {
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Binding var selectedDate: Date
    @Binding var travellers: Int
    
    let travelRange = 1...20
    
    var body: some View {
        HStack(spacing: 0){
            //date picker
            VStack(alignment: .leading, spacing: 4){
                Text("Date")
                    .font(.cardSubTitleText)
                    .foregroundColor(fontColor)
                
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Divider()
                .frame(height: 60)
                .foregroundColor(Color.AppPrimary)
            
            // no of travelles picker
            VStack(alignment: .leading, spacing: 4){
                Text("Travellers")
                    .font(.cardSubTitleText)
                    .foregroundColor(fontColor)
                
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
                .stroke(strokeColor, lineWidth: 1)
        )
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    //color change according to theme
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var strokeColor: Color{
        isDarkMode ? Color.AppPrimary : Color.AppPrimary.opacity(0.4)
        
    }
}


