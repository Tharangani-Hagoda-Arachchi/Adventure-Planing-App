//
//  ProfileView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isLogin") private var isLogin: Bool = true
    @StateObject private var userModel = UserViewModel()
    @State private var navigateDetail = false
    @State private var navigateLogin = false
    @State private var showPasswordManager = false
    @State private var showLogoutAlert = false
    
    
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
            .padding(.bottom)
            
            VStack{
                //profile details
                ProfileRawView(
                    icon: "person.circle",
                    title: "Profile Details",
                    toggleValue: .constant(false),
                    action: {
                        navigateDetail = true
                    }
                    
                )
                //mode change
                ProfileRawView(
                    icon: "sun.max",
                    title: "Change Mode",
                    isToggle: true,
                    toggleValue: $isDarkMode
                )
                //password manager
                ProfileRawView(
                    icon: "lock.circle",
                    title: "Password Manager",
                    toggleValue: .constant(false),
                    action: {
                        showPasswordManager = true
                        
                    }
                )
                //privacy policy
                ProfileRawView(
                    icon: "shield",
                    title: "Privacy Policy",
                    toggleValue: .constant(false),
                    action: {
                        print("Navigate to privacy policy")
                    }
                )
                //helps
                ProfileRawView(
                    icon: "questionmark.circle",
                    title: "Helps",
                    toggleValue: .constant(false),
                    action: {
                        print("Navigate to Helps")
                    }
                )
                
                //logout
                SecondaryRoundedActionButton(title: "Logout"){
                    showLogoutAlert = true
                    
                }.padding(50)
                
                    .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Logout", role: .destructive) {
                            if let _ = userModel.userDetails?.email {
                                TokenManager.shared.sessionLogout()
                                isLogin = false
                                
                            }
                            navigateLogin = true

                        }
                    }
            }
            .navigationDestination(isPresented: $navigateLogin) {
                LoginView()
                
            }.preferredColorScheme(isDarkMode ? .dark : .light)
                .padding()
            
            Spacer()
            
            
        }.navigationBarHidden(true)
        //navigate to profile detail view
            .navigationDestination(isPresented: $navigateDetail) {
                if let user = userModel.userDetails {
                    ProfileDetailView(user: user)
                } else {
                    //loading or error state
                    VStack {
                        ProgressView()
                        Text("Loading profile...")
                            .padding()
                    }
                }

                    
            }.onAppear{
                userModel.fetchUserById()
            }
        
        //password manager popup sheets
            .sheet(isPresented: $showPasswordManager) {
                PasswordManagerView(showSheet: $showPasswordManager)
                    .presentationDetents([.medium])
            }

        
    }
}

#Preview {
    ProfileView()
}
