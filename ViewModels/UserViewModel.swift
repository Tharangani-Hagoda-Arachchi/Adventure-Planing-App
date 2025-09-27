//
//  UserViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject{
    
    @Published var users: [User] = []
    @Published var userDetails: User? = nil//
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //sesion expire allert
    @Published var showSessionExpireAlert = false
    
    private var apiService = APIServices.shared
    
    
    
    //backend API call for fetch user
    func fetchUserById(){
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        apiService.fetchUser { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async{
                switch result{
                case .success(let user):
                    self.userDetails = user
                    
                case .failure(let error):
                    switch error{
                    case .httpError(let code) where code == 401:
                        self.handleInvalidToken()
                    default:
                        self.showErrorAlert(title: "Error", message: error.localizedDescription)
                    }

                }
                
            }

            
        }
 
    }
    
    //backend API call for update user
    func updateUserById(userId: String, name: String, phone: String, completion: @escaping (Bool, String?) -> Void){
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        apiService.updateUser(userId: userId, name: name, phone: phone) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async{
                switch result{
                case .success(let updateUser):
                    self.userDetails = updateUser
                    completion(true,nil)
                case .failure(let error):
                    switch error{
                    case .httpError(let code) where code == 401:
                        self.handleInvalidToken()
                    default:
                        self.showErrorAlert(title: "Error", message: error.localizedDescription)
                    }

                }
                
            }

            
        }
 
    }
    
    
    //backend API call for update user password
    func updateUserPassword(userId: String, newPassword: String, completion: @escaping (Bool, String?) -> Void){
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        apiService.changePassword(userId: userId, newPassword: newPassword) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async{
                switch result{
                case .success(let updateUser):
                    self.userDetails = updateUser
                    completion(true,nil)
                case .failure(let error):
                    switch error{
                    case .httpError(let code) where code == 401:
                        self.handleInvalidToken()
                    default:
                        self.showErrorAlert(title: "Error", message: error.localizedDescription)
                    }

                }
                
            }

            
        }
 
    }


    
    //func to handle invalid token
    private func handleInvalidToken(){
        TokenManager.shared.sessionLogout()
        DispatchQueue.main.async{
            self.showSessionExpireAlert = true
        }
    }
    
    // function for show error alerts
    private func showErrorAlert(title: String, message: String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }


    
}

    


