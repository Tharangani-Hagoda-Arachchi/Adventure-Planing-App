//
//  AdventureViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//


import Foundation
import SwiftUI

class AdventureViewModel : ObservableObject{
    
    @Published var adventures: [Adventure] = []
    @Published var selectedItem: Adventure? = nil
    @Published var selectedAdventureId: Adventure? = nil
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //sesion expire allert
    @Published var showSessionExpireAlert = false
    
    private var apiService = APIServices.shared
    
    
    
    //backend API call for fetch adventures
    func fetchAdventure(){
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        apiService.fetchAdventures { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async{
                switch result{
                case .success(let adventures):
                    self.adventures = adventures
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
    
    func selectAdventure(_ adventure: Adventure){
        selectedItem = adventure
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









