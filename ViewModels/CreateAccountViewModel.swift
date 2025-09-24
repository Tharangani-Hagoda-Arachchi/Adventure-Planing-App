//
//  CreateAccountViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import Foundation
import SwiftUI

class CreateAccountViewModel : ObservableObject{
    
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    //error masseges
    @Published var errorName : String?
    @Published var errorEmail : String?
    @Published var errorPhone : String?
    @Published var errorPassword : String?
    @Published var errorConfirmPassword : String?
    
    //validation status
    @Published var isValid = false
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    private let apiService = APIServices.shared


    
    // validation check function
    func validateCreateAccount(){
        
        //assign errors to nill
        errorName = nil
        errorEmail = nil
        errorPhone = nil
        errorPassword = nil
        errorConfirmPassword = nil
        
        if name.isEmpty{
            errorName = "Enter Your Name"
        }
        
        if email.isEmpty{
            errorEmail = "Enter Your Email"
        }else if !isValidEmail(email){
            errorEmail = "Invalid Email"
        }
        
        if phone.isEmpty{
            errorPhone = "Enter Your Phone No"
        }else if !isValidPhone(phone){
            errorPhone = "Invalid Phone No"
        }
        
        if password.isEmpty{
            errorPassword = "Enter Your Password"
        }else if !isValidPassword(password){
            errorPassword = "At least 6 chars, 1 uppercase, 1 lowercase, 1 number, 1 special char"
        }
        
        if confirmPassword.isEmpty{
            errorConfirmPassword = "Confirm Your Password"
        }else if confirmPassword != password{
            errorConfirmPassword = "Password Mismatch"
        }
        
        isValid = (errorName == nil && errorEmail == nil && errorPhone == nil && errorPassword == nil && errorConfirmPassword == nil)
             
        
    }
    
    // validate emai using regex
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    // validate phone no using regex (use country code)
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegEx = "^\\+?[0-9]{1,3}?[0-9]{9,10}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegEx).evaluate(with: phone)
    }
    
    // validate password using regex
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: password)
    }
    
    //backend API call for registration
    func useRegistration(){
        apiService.registerUser(name: name, email: email, phone: phone, password: password) { [weak self] result in
            guard let self = self else{return}
            
            switch result {
            case .success(let response):
                if let token = response.accessToken{
                    self.handleSuccessfulRegistration(token: token)
                } else{
                    self.showErrorAlert(title: "Error", message: "Failed to create account")
                }
            case .failure(let error):
                if error.localizedDescription.contains("409"){
                    self.showErrorAlert(title: "Failed Acount Creation", message: "Email is already registered")
                    
                } else{
                    self.showErrorAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    // function for handle successfull registration
    private func handleSuccessfulRegistration(token: String){
        // save access token using token manager
        TokenManager.shared.saveAccessToken(token)
        
        //save credetial to keychain for face ID login
        if let passwordData = password.data(using: .utf8){
            KeyChainHelper.shared.save(service: "AdventureAPP", account: email, data: passwordData)
        }
        
        UserDefaults.standard.set(email, forKey: "LastRegisteredEmail")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        clearFormField()
        
        BiometricAuthHelper.shared.authenticateWithFaceID { success, _ in
            if success{
                print("Face ID setup completed")
            }else {
                print("Face ID declines")
            }
            
        }
        
        showSuccessAlert()
    }
    
    //clear fom fields
    private func clearFormField(){
        name = ""
        email = ""
        phone = ""
        password = ""
        confirmPassword = ""
    }
    
    // function for show success alerts
    private func showSuccessAlert(){
        alertTitle = "Success"
        alertMessage = "Acount created successfuly"
        showAlert = true
    }
    
    // function for show error alerts
    private func showErrorAlert(title: String, message: String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }

    
}




