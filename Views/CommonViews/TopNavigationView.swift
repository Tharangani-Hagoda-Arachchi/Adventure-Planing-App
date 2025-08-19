//
//  TopNavigationView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct TopNavigationView: View {
    @State private var navigateNotification = false
    @State private var navigateFavourite = false
    @State private var navigateProfile = false
    
    var body: some View {
        NavigationStack{
            
            HStack(spacing:12){
                
                //notification
                NavigationLink(destination: NotificationView()){
                    Image(systemName: "bell.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                }
                
                //favourite icon
                NavigationLink(destination: FavouriteView()){
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                }
                
                //profile icon
                NavigationLink(destination: ProfileView()){
                    Image(systemName: "person.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                }


                

            }
            
            .padding(.horizontal,16)
            .padding(.top, 10)
            //make top right corner
            .frame(maxWidth: .infinity, alignment: .trailing)
             Spacer()
            
        }
        
        //navigate to notification view
        .navigationDestination(isPresented: $navigateNotification){
            NotificationView()
        }
        
        //navigate to Favourite view
        .navigationDestination(isPresented: $navigateFavourite){
            FavouriteView()
        }
        
        //navigate to profile view
        .navigationDestination(isPresented: $navigateProfile){
            ProfileView()
        }


        

    }
        
}

#Preview {
    TopNavigationView()
}
