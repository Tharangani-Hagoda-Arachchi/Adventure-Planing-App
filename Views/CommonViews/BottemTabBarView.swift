//
//  BottemTabBarView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import SwiftUI

//enum for tabs
enum Tab: Equatable{
    case home
    case map
    case event
    case packages
    case none
}

struct BottemTabBarView: View {
   
    @Binding var selectedTab: Tab
    @Binding var showSearch: Bool
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false

    
    var body: some View {
 
            HStack(spacing: 12){
                
                //custom tab bar icons
                HStack{
                    TabButtonView(systemImage: "house.fill",title: "Home", isSelect:selectedTab == .home){
                        selectedTab = .home
                        showSearch = false
                    }
                    
                    TabButtonView(systemImage: "location.fill",title: "Map", isSelect:selectedTab == .map){
                        selectedTab = .map
                        showSearch = false
                        
                    }
                    TabButtonView(systemImage: "calendar.badge.plus",title: "Events", isSelect:selectedTab == .event){
                        selectedTab = .event
                        showSearch = false
                    }
                    TabButtonView(systemImage: "suitcase.fill",title: "Packages", isSelect:selectedTab == .packages){
                        selectedTab = .packages
                        showSearch = false
                    }
                    
                    
                }
                .padding(.horizontal, 16)
                .background(tabBarBackgroundColor.ignoresSafeArea(edges: .bottom))
                .cornerRadius(20)
                .overlay(Capsule().stroke(Color.AppPrimary, lineWidth: 1))
                .shadow(color: tabBarShadowColor,radius: 4)
                
                //serch icon
                Button(action:{
                    //serch logic
                    showSearch.toggle()
                }) {
                    Image(systemName: showSearch ? "xmark" : "magnifyingglass")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(searchiconColor)
                        .padding()
                        .background(Circle().fill(searchBackgroundColor))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                        .shadow(color: tabBarShadowColor,radius: 4)
                          .animation(.easeInOut(duration: 0.2), value: showSearch)
                }
                
            }.padding(.horizontal,16)
             .padding(.bottom,5)
             .preferredColorScheme(isDarkMode ? .dark : .light)
                
            }
    
    //color according to mode
    private var tabBarBackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.2) : Color.AppButtonText
        
    }
    
    private var tabBarShadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.1) : Color.AppPrimaryTextField.opacity(0.3)
        
    }
    
    private var searchiconColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var searchBackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.3) : Color.AppButtonText
        
    }
      
            

            
       
            
        
        
    
}




