//
//  AdventureView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/09/2025.
//

import SwiftUI

struct AdventureView: View {
    @State private var selectedTab: Tab = .home
    
    let categoryId: String
    
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    
    @AppStorage("isLogin") private var isLogin: Bool = false
    
    private let columns  = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {

            VStack{
                //top navigation
                TopNavigationView()
                
                Text("Adventures")
                    .font(Font.buttonLargeText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
            }
            ScrollView{
                LazyVStack(spacing: 16){
                    ForEach(adventurePlaceModel.places){ place in
                        NavigationLink(destination: AdventureDetailView(placeId: place.id)) {
                            AdventureCadView(adventurePlace: place)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            
                        }
                        .buttonStyle(PlainButtonStyle())  

                    }
                }
                .padding(.top, 16)
                
                //alerts
                .alert(isPresented:$adventurePlaceModel.showSessionExpireAlert){
                    Alert(
                        title: Text("Session Expired"),
                        message: Text("Please login again"),
                        dismissButton: .default(Text("OK")){
                            DispatchQueue.main.async{
                                TokenManager.shared.sessionLogout()
                                isLogin = false
                                adventurePlaceModel.showSessionExpireAlert = false
                                
                            }

                                            
                        }
                    )
                }

            }
            .padding(.bottom,16)
            .onAppear{
                adventurePlaceModel.fetchPlacesByCategory(for: categoryId)
            }
            .navigationBarHidden(true)
        BottemTabBarView(selectedTab: $selectedTab)
                        .edgesIgnoringSafeArea(.bottom)
            
        
        
    }
}

//#Preview {
   // AdventureView()
//}
