//
//  HomeView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab : Tab = .none
    var body: some View {
        NavigationStack{
            VStack{
                TopNavigationView()
                Spacer()
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
                BottemTabBarView(selectedTab: $selectedTab)
                    .edgesIgnoringSafeArea(.bottom)
            
            }
            .navigationBarHidden(true)
        }

        
    }
}

#Preview {
    HomeView()
}
