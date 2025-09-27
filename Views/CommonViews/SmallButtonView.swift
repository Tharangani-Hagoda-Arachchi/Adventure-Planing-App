//
//  SmallButtonView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//

import SwiftUI


struct SmallButtonView: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        Button(action: action){
            Text(title.capitalized)
                .font(Font.primarysBoldText)
                .foregroundColor(fontColor)
                .frame(maxWidth:200)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(backgroundColor)
                .cornerRadius(15)
                .shadow(color: shadowColor,radius: 4)
            
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
    
    //adjust font collor according to  mode
    private var fontColor: Color{
        if isDarkMode{
            return isSelected ? Color.AppButtonText: Color.AppButtonText
        }else{
            return Color.AppPrimaryTextField
        }
    }
    
    //adjust background collor according to  mode
    private var backgroundColor: Color{
        if isDarkMode{
            return isSelected ? Color.AppPrimary.opacity(0.6): Color.AppButtonText.opacity(0.1)
        }else{
            return isSelected ? Color.AppPrimary.opacity(0.4): Color.AppPrimaryTextField.opacity(0.1)
        }
    }
    
    //shadow color according to made
    private var shadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.2) : Color.AppPrimaryTextField.opacity(0.2)
    }
    
}


