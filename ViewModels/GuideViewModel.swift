//
//  GuideViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import Foundation
import SwiftUI

class GuideViewModel : ObservableObject{
    
    @Published var guides: [Guide] = []
    @Published var guideDetail: Guide? = nil// for single responce
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //load status
    @Published var isLoad = false
    
    private var apiService = APIServices.shared
    
    //sesion expire allert
    @Published var showSessionExpireAlert = false
    

    
    //backend API call for fetch guide by place
    func fetchGuide(for placeName: String, completion: @escaping ([Guide]) -> Void = {_ in}){
        
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        isLoad = true
        
        apiService.fetchGuides(by: placeName) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoad = false
            
            switch result{
            case .success(let guides):
                self.guides = guides
                completion(guides)
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
    
    //backend API call for fetch guide  by ID
    func fetchGuideByID(for id: String, completion: @escaping (Guide?) -> Void = {_ in}){
        
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        isLoad = true
        
        apiService.fetchGuide(by: id) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoad = false
            
            switch result{
            case .success(let guide):
                self.guideDetail = guide
                completion(guide)
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






