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
    
    @AppStorage("isLogin") private var isLogin: Bool = false
    
    
    var body: some View {
        NavigationStack{
            
            VStack(){
                
                //top navigation view
                TopNavigationView(showBackButton: false)
                
                Text("Hello Jone")
                    .font(Font.buttonLargeText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("Welcome to Travel Mate")
                    .font(Font.SubTitleSmallText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])

                
                ScrollView{
                    LazyVStack(){
                        
                        // display adventure categories
                        AdventureCategoryRaw(adventureViewModel: adventureModel) { categoryId in
                            selectedCategoryId = categoryId
                            showPlaces = true
                        }
                        .padding(.bottom)
                        
                        Image("sri-lanka-nature-camping")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .cornerRadius(15)
                            .overlay(
                                
                                ZStack{
                                    Text("Discover the TravelMate")
                                        .font(.TitleText)
                                        .foregroundColor(Color.AppButtonText)
                                        .background(Color.AppPrimaryTextField.opacity(0.4))
                                        .offset(x: -60, y: -30)
                                        .padding(.bottom,20)
                                    
                                    
                                    Text("Discover adventure starting this season")
                                        .font(.cardSubTitleSmallText)
                                        .foregroundColor(Color.AppButtonText)
                                        .background(Color.AppPrimaryTextField.opacity(0.4))
                                        .offset(x: -27, y: 20)
                                        .padding(.bottom,20)
                                    
                                    //explore button
                                    Button(action: {
                                        
                                    }){
                                        Text("Explore...")
                                            .font(.primarysBoldText)
                                            .foregroundColor(Color.AppButtonText)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [ Color.AppPrimary,Color.AppPrimary.opacity(0.7)]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .cornerRadius(15)
                                            .shadow(color: .AppPrimaryTextField.opacity(0.25), radius: 5, x: 0, y: 3)
                                            .offset(x: -100, y: 50)
                                    }
                                    
                                }
                                
                            ).padding(.horizontal,20)
                        
                    }
                }
                
                
                

                
  
                
                    
            }
            .padding()
            
            //alerts
            .alert(isPresented:$adventureModel.showSessionExpireAlert){
                Alert(
                    title: Text("Session Expired"),
                    message: Text("Please login again"),
                    dismissButton: .default(Text("OK")){
                        DispatchQueue.main.async{
                            TokenManager.shared.sessionLogout()
                            isLogin = false
                            adventureModel.showSessionExpireAlert = false
                            
                        }

                                        
                    }
                )
            }

            
        }
       

        
            .onAppear{
                adventureModel.fetchAdventure()
            }
        
            //navigate adventure view with selected category
            .navigationDestination(isPresented: $showPlaces) {
                if let categoryId = selectedCategoryId {
                    AdventureView(categoryId: categoryId)
                }
            }
            .navigationBarHidden(true)
            
            }
            
        
    
}

#Preview {
    NavigationStack{
        HomeView()
    }
    
}
