//
//  GuideDetailCardView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct GuideDetailCardView: View {
    let lable: String
    let value: String
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(spacing:4){
            HStack(alignment: .top){
                
                Text("\(lable)")
                    .font(.cardSubTitleSmallText)
                    .foregroundColor(fontColor)
                    .frame(width: 120, alignment: .leading)
                
                Text(value)
                    .font(.cardSmallText)
                    .foregroundColor(fontColor)
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
            Divider()
                .background(deviderColor)
            
        }
        .padding(.vertical, 4)
        .shadow(color: cardShadowColor, radius:5 , x:0, y: 2)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        

        
    }
    
    //color change according to theme
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var deviderColor: Color{
        isDarkMode ? Color.gray : Color.gray.opacity(0.3)
        
    }
    
    private var cardShadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.1) : Color.AppPrimaryTextField.opacity(0.4)
        
    }
}


