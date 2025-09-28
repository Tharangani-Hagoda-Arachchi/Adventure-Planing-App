//
//  TopNavigationView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct TopNavigationView: View {
    @State private var navigateNotification = false
    @State private var navigateFavourite = false
    @State private var navigateProfile = false
    @State private var selectedTab: Tab = .none
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    @Environment(\.dismiss) private var dismiss
    
    var showBackButton: Bool = true
    var onBack: (() -> Void)? = nil
    
    var body: some View {
        
        HStack(spacing:12){
            if showBackButton{
                Button{
                    if let onBack = onBack{
                        onBack()
                    }else{
                        dismiss()
                    }
                }label:{
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(backButtonColor)
                }
                
            }
            
            Spacer()
            //notification
            NavigationLink(destination: NotificationView()){
                Image(systemName: "bell.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(iconColor)
                    .padding(10)
                    .background(Circle().fill(iconBackgroundColor))
                    .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                    .shadow(color: shadowColor,radius: 4)
            }
            
            //favourite icon
            NavigationLink(destination: FavouriteView()){
                Image(systemName: "heart.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(iconColor)
                    .padding(10)
                    .background(Circle().fill(iconBackgroundColor))
                    .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                    .shadow(color: shadowColor,radius: 4)
            }
            
            //profile icon
            NavigationLink(destination: ProfileView()){
                Image(systemName: "person.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(iconColor)
                    .padding(10)
                    .background(Circle().fill(iconBackgroundColor))
                    .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                    .shadow(color: shadowColor,radius: 4)
            }
            
            
            
            
            
        }
        .padding(.horizontal,16)
        .padding(.vertical, 5)
        //make top right corner
        .frame(maxWidth: .infinity, alignment: .trailing)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
        
    }
    
    //adjust components collor according to mode
    
    private var backButtonColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
    }
    
    private var iconColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
    }
    
    private var iconBackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.3) : Color.AppButtonText
    }
    
    private var shadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.1) : Color.AppPrimaryTextField.opacity(0.3)
    }

    
        
}

#Preview {
    VStack{
        TopNavigationView()
        Spacer()
       
        
    }

}
