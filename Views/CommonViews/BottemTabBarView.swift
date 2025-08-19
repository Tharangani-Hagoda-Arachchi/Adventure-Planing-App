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
    
    var body: some View {
        VStack(spacing: 0){
            
            ZStack(alignment: .bottom){
                switch selectedTab {
                case .home: HomeView()
                case .map: MapView()
                case .event :EventView()
                case .packages: PackageView()
                case .none: EmptyView()
                }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 12){
                
                //custom tab bar icons
                HStack{
                    TabButtonView(systemImage: "house.fill",title: "Home", isSelect:selectedTab == .home){
                        selectedTab = .home
                    }
                    
                    TabButtonView(systemImage: "location.fill",title: "Map", isSelect:selectedTab == .map){
                    
                        selectedTab = .map
                        
                    }
                    TabButtonView(systemImage: "calendar.badge.plus",title: "Events", isSelect:selectedTab == .event){
                        selectedTab = .event
                    }
                    TabButtonView(systemImage: "suitcase.fill",title: "Packages", isSelect:selectedTab == .packages){
                        selectedTab = .packages
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
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                        
                }
                
            }
            .padding(.horizontal,16)
            .padding(.bottom,40)
            
        }
        .ignoresSafeArea(edges: .bottom)

        
    }
}




