//
//  ProfileView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var isDarkMode = false
    var body: some View {
        NavigationStack{
        
        VStack(alignment: .leading, spacing: 12){
            //top navigation view
            TopNavigationView()
            
            Text("Profile")
                .font(Font.buttonLargeText)
                .foregroundColor(Color.AppPrimaryTextField)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,20)
        }
            Spacer()
        
       ProfileRawView(
            icon: "person.circle",
            title: "Profile Details",
            toggleValue: .constant(false),
            action: {
                print("Navigate to Profile Details")
            }
                    
       )
        ProfileRawView(
            icon: "sun.max",
            title: "Change Mode",
            isToggle: true,
            toggleValue: $isDarkMode
        )
        ProfileRawView(
            icon: "lock.circle",
            title: "Password Manager",
            toggleValue: .constant(false),
            action: {
                print("Navigate to Password Manage")
            }
        )
        
        ProfileRawView(
            icon: "shield",
            title: "Privacy Policy",
            toggleValue: .constant(false),
            action: {
                print("Navigate to privacy policy")
            }
        )
        ProfileRawView(
            icon: "questionmark.circle",
            title: "Helps",
            toggleValue: .constant(false),
            action: {
                print("Navigate to Helps")
            }
        )
            Spacer()
            
        
        HStack{
            SecondaryRoundedActionButton(title: "Logout"){
                //load packeges function
            }
           
            
            
        }
            
            
        }.navigationBarHidden(true)
            


        
    }
}

#Preview {
    ProfileView()
}
