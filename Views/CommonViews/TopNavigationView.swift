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
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            
            HStack(spacing:12){
                Button(action: {
                    dismiss()  // default back
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color.AppPrimaryTextField)
                }
                Spacer()
                //notification
                NavigationLink(destination: NotificationView()){
                    Image(systemName: "bell.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                }
                
                //favourite icon
                NavigationLink(destination: FavouriteView()){
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                }
                
                //profile icon
                NavigationLink(destination: ProfileView()){
                    Image(systemName: "person.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 1))
                          .shadow(radius: 4)
                }


                

            }
            .padding(.horizontal,16)
            .padding(.vertical, 5)
            //make top right corner
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
        }
        
        //navigate to notification view

    

        

    
        
}

#Preview {
    VStack{
        TopNavigationView()
        Spacer()
       
        
    }

}
