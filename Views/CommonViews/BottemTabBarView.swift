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
    
    //@State private var homePath = NavigationPath()
   // @State private var mapPath = NavigationPath()
   // @State private var eventPath = NavigationPath()
   // @State private var packagePath = NavigationPath()
    
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
                .background(Color.AppButtonText.ignoresSafeArea(edges: .bottom))
                .cornerRadius(20)
                .overlay(Capsule().stroke(Color.AppPrimary, lineWidth: 1))
                .shadow(radius: 4)
                
                //serch icon
                Button(action:{
                    //serch logic
                    showSearch.toggle()
                }) {
                    Image(systemName: showSearch ? "xmark" : "magnifyingglass")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                          .animation(.easeInOut(duration: 0.2), value: showSearch)
                }
                
            }.padding(.horizontal,16)
             .padding(.bottom,5)
                
            }
            

            
       
            
        
        
    
}




