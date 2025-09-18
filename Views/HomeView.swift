//
//  HomeView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var adventureModel = AdventureViewModel()
    
    @State private var selectedCategoryId: String? = nil
    @State private var showPlaces = false
    
    
    
    var body: some View {
       
            VStack(spacing: 0){
                
                //top navigation view
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
                
                // display adventure categories
                AdventureCategoryRaw(adventureViewModel: adventureModel) { categoryId in
                    selectedCategoryId = categoryId
                    showPlaces = true
                }
                    
            }.padding(.horizontal)
            .onAppear{
                adventureModel.fetchAdventure()
            }
            //navigate adventure view with selected category
            .navigationDestination(isPresented: $showPlaces) {
                if let categoryId = selectedCategoryId {
                    AdventureView(categoryId: categoryId)
                }
            }
            //.navigationBarHidden(true)
            
            }
            
        
    
}

#Preview {
    NavigationStack{
        HomeView()
    }
    
}
