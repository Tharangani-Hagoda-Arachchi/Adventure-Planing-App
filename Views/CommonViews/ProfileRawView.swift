//
//  ProfileRawView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI

struct ProfileRawView: View {
    let icon: String
    let title: String
    var isToggle: Bool = false
    @Binding var toggleValue: Bool
    var action: (() -> Void)? = nil
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {

            HStack{
                Image(systemName: icon)
                    .frame(width: 24, height:24)
                    .foregroundColor(iconColor)
                    
                
                Text(title)
                    .font(.cardSubTitleText)
                    .foregroundColor(fontColor)
                
                Spacer()
                if isToggle {
                    Toggle("", isOn: $toggleValue).labelsHidden()
                 } else {
                    Image(systemName: "chevron.right")
                         .foregroundColor(iconColor)
                 }

            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
            .onTapGesture {
                if !isToggle {
                    action?()
                }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
        Divider()
            .background(Color.gray.opacity(0.5))
    }
    
    //color change according to theme
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var backgroundColor: Color{
        isDarkMode ? Color.AppPrimaryTextField: Color.AppButtonText
        
    }
    
    private var iconColor: Color{
        isDarkMode ? Color.gray : Color.AppPrimaryTextField
        
    }
}

