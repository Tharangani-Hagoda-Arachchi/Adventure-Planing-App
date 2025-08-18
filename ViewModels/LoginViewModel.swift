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
    
}





