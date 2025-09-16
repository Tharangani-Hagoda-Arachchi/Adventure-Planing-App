//
//  HomeView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab : Tab = .none
    @StateObject private var adventureModel = AdventureViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                TopNavigationView()
                
                Text("Hello Jone")
                    .font(Font.buttonLargeText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
                Text("Welcome to Travel Mate")
                    .font(Font.SubTitleSmallText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
                
                //AdventureCategoryRaw(adventureViewModel: adventureModel)
                


                    
                    
                    
                }.padding(.horizontal)
                .onAppear{
                    adventureModel.fetchAdventure()
                }

                
                BottemTabBarView(selectedTab: $selectedTab)
                    .edgesIgnoringSafeArea(.bottom)
            
            }
            .navigationBarHidden(true)
        }

        
    
}

#Preview {
    HomeView()
}
