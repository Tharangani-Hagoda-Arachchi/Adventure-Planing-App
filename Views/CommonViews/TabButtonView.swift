//
//  TabButtonView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import SwiftUI

struct TabButtonView: View {
    let systemImage: String
    let title: String
    let isSelect: Bool
    let action: () -> Void
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        Button(action: action){
            VStack{
                Image(systemName: systemImage)
                    .font(Font.primaryRegularText)
                    .foregroundColor(iconColor)
                Text(title)
                    .font(.caption)
                    .foregroundColor(fontColor)
            }

            .padding(.vertical,10)
            .frame(maxWidth: .infinity)

        }.preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
    
    //adjust icon collor according to  mode
    private var iconColor: Color{
        if isDarkMode{
            return isSelect ? Color.AppSecondary: Color.AppButtonText
        }else{
            return isSelect ? Color.AppSecondary: Color.AppPrimaryTextField
        }
    }
    
    //adjust font collor according to  mode
    private var fontColor: Color{
        if isDarkMode{
            return isSelect ? Color.AppSecondary: Color.AppButtonText
        }else{
            return isSelect ? Color.AppSecondary: Color.AppPrimaryTextField
        }
    }

}

