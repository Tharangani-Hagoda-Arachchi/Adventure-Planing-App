//
//  MainTabView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/09/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @StateObject private var viewModel = AdventurePlannerViewModel()
    
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
            BottemTabBarView(selectedTab: $selectedTab)
                            .edgesIgnoringSafeArea(.bottom)
            
        }
    }
}

#Preview {
    MainTabView()
}
