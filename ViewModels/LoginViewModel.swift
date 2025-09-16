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
        
        if errorEmail == nil && errorPassword == nil {
            isValid = true
        }
    }
    
    //backend API call for login
    func useLogin(){
        //backend url
        guard let url = URL(string: "http://13.60.76.232/api/auths/signin") else {return}
        
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
                var token: String?
                
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let message = json["message"] as? String {
                        responseMessage = json["message"] as? String ?? responseMessage
                        token = json["token"] as? String
                    }
                }
                
                if httpResponce.statusCode == 200, let token = token {
                    // save token
                    KeyChainHelper.shared.save(service: "AdventureAPP", account: "userToken", data: Data(token.utf8))
                    // Save email for Face ID
                    UserDefaults.standard.set(self.email, forKey: "LastRegisteredEmail")
                    
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
        else {return}
        
        BiometricAuthHelper.shared.authenticateWithFaceID{success, authError in
            if success{
                if let data = KeyChainHelper.shared.read(service: "AdventureAPP", account: savedEmail),
                   let savedPassword = String(data: data, encoding: .utf8){
                    DispatchQueue.main.async{
                        self.email = savedEmail
                        self.password = savedPassword
                        self.useLogin()
                        
                        
                    }
                }else{
                    print("FaceId login fail")
                }
                
            }
        }
    }
        
    
}





