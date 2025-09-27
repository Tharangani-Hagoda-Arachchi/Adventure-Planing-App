//
//  PasswordManagerView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import SwiftUI

struct PasswordManagerView: View {
    
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isUserDataLoaded: Bool = false
    
    @Binding var showSheet: Bool
    @State private var errormessage = ""
    
    @StateObject private var registerViewModel = CreateAccountViewModel()
    @StateObject private var userModel = UserViewModel()
    

    
    var body: some View {
        VStack(spacing: 20){
            Text("Change Password")
                .font(.primarysBoldText)
                .padding(.top,10)
            
            CustomTextFieldView(
                icon: "lock.fill", placeHolder: "Password", isSecure: true, text: $registerViewModel.password
            )
            ErrorTextView(error: registerViewModel.errorPassword)
            
            CustomTextFieldView(
                icon: "lock.fill", placeHolder: "Confirm Password", isSecure: true, text: $registerViewModel.confirmPassword
            )
            ErrorTextView(error: registerViewModel.errorConfirmPassword)
            
            CustomPrimaryButtonView(title: isLoading ? "Saving..." : "Save Changes"){
                handleResetPassword()
                
            }.disabled(isLoading)
        }.padding()
            .onAppear{
                loadUserData()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Change Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")){
                    if alertMessage == "Password Updated Successfuly"{
                        showSheet = false
                    }
                }
                )
                
            }
        
        
    }
    
    // function to load user data
    private func loadUserData(){
        guard !isUserDataLoaded else {return}
        
        userModel.fetchUserById()
    }
    
    // function to handle save
    private func handleResetPassword(){
        registerViewModel.validateCreateAccount()
        
        guard registerViewModel.isValid else{
            isLoading = false
            return
        }
        
        guard let userId = userModel.userDetails?.id else{
            alertMessage = "user ID not Found"
            showAlert = true
            isLoading = false
            return
        }
        
        isLoading = true
        
        userModel.updateUserPassword(userId: userId, newPassword: registerViewModel.password) { success, message in
            isLoading = false
            if success{
                alertMessage = "Password Updated Successfuly"
                showAlert = true
            }else{
                alertMessage = message ?? "Fail update"
                showAlert = true
            }
            
        }
        
        
    }
}
