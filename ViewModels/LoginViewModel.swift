//
//  LoginViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import Foundation
import SwiftUI
import LocalAuthentication

class LoginViewModel : ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    //error masseges
    @Published var errorEmail : String?
    @Published var errorPassword : String?
    
    //validation status
    @Published var isValid = false
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //login status
    @Published var isLogin = false
    
    private var apiService = APIServices.shared
    
    
    
    
    // validation check function
    func validateLoginAccount(){
        
        //assign errors to nill
        errorEmail = nil
        errorPassword = nil
        
        if email.isEmpty{
            errorEmail = "Enter Your Email"
        }
        
        if password.isEmpty{
            errorPassword = "Enter Your Password"
        }
        
        isValid = (errorEmail == nil && errorPassword == nil )
        
        
    }
    
    //backend API call for login
    func useLogin(email: String? = nil, password: String? = nil){
        
        let loginEmail = email ?? self.email
        let loginPassword = password ?? self.password
        
        apiService.loginUser(email: loginEmail, password: loginPassword) { [weak self] result in
            guard let self = self else{return}
            
            switch result {
            case .success(let response):
                if let success = response.success, success, let token =  response.accessToken{
                    self.handleSuccessfulRLogin(email: loginEmail, token: token)
                }else{
                    self.showErrorAlert(title: "Error", message: response.message)
                }
            case .failure(let error):
                if error.localizedDescription.contains("401"){
                    self.showErrorAlert(title: "Failed Login", message: "Invalid Email or Password")
                    
                } else{
                    self.showErrorAlert(title: "Error", message: error.localizedDescription)
                }
                

                
            }
            
            
        }
        
    }
    
    // function for handle successfull login
    private func handleSuccessfulRLogin(email: String, token: String){
        // save access token using token manager
        TokenManager.shared.saveAccessToken(token)
        
        UserDefaults.standard.set(email, forKey: "LastRegisteredEmail")
        
        if let passwordData = (self.password.isEmpty ? nil : self.password.data(using: .utf8)) {
            KeyChainHelper.shared.save(service: "AdventureAPP", account: email, data: passwordData)
        }
        
        self.email = ""
        self.password = ""
        self.isLogin = true
        
    }
    
    // function for show error alerts
    private func showErrorAlert(title: String, message: String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    
    //get save email function
    private func getSavedEmail() -> String?{
        UserDefaults.standard.string(forKey: "LastRegisteredEmail")
    }
    
    //Auto face ID loging logic
    func autoFaceIDLogin(){
        let context = LAContext()
        var error : NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error),
              let savedEmail = getSavedEmail()
        else {
            print("Face ID unavailable or no saved email")
            return
        }
        
        BiometricAuthHelper.shared.authenticateWithFaceID{success, authError in
            if success{
                if let data = KeyChainHelper.shared.read(service: "AdventureAPP", account: savedEmail),
                   let savedPassword = String(data: data, encoding: .utf8){
                    DispatchQueue.main.async{
                        self.useLogin(email: savedEmail,password: savedPassword)
                        
                    }
                }else{
                    print("FaceId login fail no saved password")
                }
                
            } else if let authError = authError {
                print("Face ID authentication failed:", authError.localizedDescription)
            }
        }
    }
    
    
}





