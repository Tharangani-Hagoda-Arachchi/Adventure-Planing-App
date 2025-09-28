//
//  NotificationCardView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 28/09/2025.
//

import SwiftUI

struct NotificationCardView: View {
    let title: String
    let message: String
    let date: Date
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        HStack(alignment:.top, spacing: 12){
            Image(systemName: "bell.fill")
                .foregroundColor(.white)
                .padding(10)
                .background(Color.red)
                .clipShape(Circle())
                    
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.cardSubTitleText)
                    .foregroundColor(fontColor)
                Text(message)
                    .font(.cardText)
                    .foregroundColor(fontColor)
                Text(date, style: .time)
                    .font(.cardSmallText)
                    .foregroundColor(.gray)
                
            }
            
        }
        .padding()
        .background(cardbackgroundColor)
        .cornerRadius(16)
        .shadow(color: cardShadowColor, radius:5 , x:0, y: 2)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    // for mode changes
    
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    private var cardbackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.2) : Color.AppButtonText
        
    }
    
    private var cardShadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.1) : Color.AppPrimaryTextField.opacity(0.4)
        
    }
}
