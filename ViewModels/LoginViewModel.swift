//
//  LoginViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import Foundation
import SwiftUI

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
    
    

    
    // validation check function
    func validateCreateAccount(){
        
        //assign errors to nill
        errorEmail = nil
        errorPassword = nil

        if email.isEmpty{
            errorEmail = "Enter Your Email"
        }
        
        if password.isEmpty{
            errorPassword = "Enter Your Password"
        }
        
        if errorEmail == nil && errorPassword == nil {
            isValid = true
        }
    }
    
    //backend API call for login
    func useLogin(){
        //backend url
        guard let url = URL(string: "http://localhost:4000/api/auths/signin") else {return}
        
        let body: [String: Any] = [
            
            "email": email,
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
                
                //get responce message as string
                var responseMessage = "Something went wrong"
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let message = json["message"] as? String {
                        responseMessage = message
                    }
                }
                
                if httpResponce.statusCode == 200 {
                    
                    // clear text fields
                    self.email = ""
                    self.password = ""
                    self.isLogin = true
                    
                }else{
                    self.alertTitle = "Error"
                    self.alertMessage = responseMessage
                    self.showAlert = true
                    
                }

                
            }
        }.resume()
    }
        
    
}





