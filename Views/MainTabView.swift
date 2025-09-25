//
//  MainTabView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/09/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @State private var showSearch = false
    @StateObject private var viewModel = AdventurePlannerViewModel()
    
    // shared search view models
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    @StateObject private var packageModel = PackageViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                switch selectedTab {
                case .home:
                    HomeView()
                case .map:
                    MapView()
                case .event:
                    EventView(viewModel: viewModel)
                case .packages:
                    PackageView()
                case .none:
                    HomeView()
                }
            }
            .blur(radius: showSearch ? 5 : 0)
            .animation(.easeInOut(duration: 0.3), value: showSearch)
            
            BottemTabBarView(selectedTab: $selectedTab, showSearch: $showSearch)
                .edgesIgnoringSafeArea(.bottom)
            
        }
        .overlay(
            Group{
                if showSearch{
                    SearchView(
                        isPresented: $showSearch,
                        selectedTab: $selectedTab,
                        adventurePlaceModel: adventurePlaceModel,
                        packageModel: packageModel
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
                }
            }
        )
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showSearch)

    }
}

#Preview {
    MainTabView()
}
