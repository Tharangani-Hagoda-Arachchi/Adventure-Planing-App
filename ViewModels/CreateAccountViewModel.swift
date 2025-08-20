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
        
        if errorName == nil && errorEmail == nil && errorPhone == nil && errorPassword == nil && errorConfirmPassword == nil{
            isValid = true
        }
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
        //backend url
        guard let url = URL(string: "http://localhost:3000/api/auths/signup") else {return}
        
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "password": password
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        //crate  request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        //send request async way
        URLSession.shared.dataTask(with: request){
            data, responce,error in DispatchQueue.main.async{
                
                //for nerwork error alert
                if let error = error{
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    return
                    
                }
                guard let httpResponce = responce as? HTTPURLResponse else {return}
                
                if httpResponce.statusCode == 201 {
                    self.alertTitle = "Success"
                    self.alertMessage = "Account created successfully"
                    // clear text fields
                    self.name = ""
                    self.email = ""
                    self.phone = ""
                    self.password = ""
                    self.confirmPassword = ""
                } else{
                    self.alertTitle = "Error"
                    self.alertMessage = "Failed create account. Try again"
                    
                }
                
                if httpResponce.statusCode == 409 {
                    self.alertTitle = "Acount Creation Failed"
                    self.alertMessage = "Email is already registered"
                }
                self.showAlert = true
            }
        }.resume()
        
        
    }
    
}




