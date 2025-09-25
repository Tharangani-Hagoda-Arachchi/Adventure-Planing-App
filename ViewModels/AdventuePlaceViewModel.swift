//
//  AdventuePlaceViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/09/2025.
//

import Foundation
import SwiftUI

class AdventuePlaceViewModel : ObservableObject{
    
    @Published var places: [AdventurePlace] = []
    @Published var placeDetail: AdventurePlace? = nil// for single responce
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    private var apiService = APIServices.shared
    
    //sesion expire allert
    @Published var showSessionExpireAlert = false
    
    //load status
    @Published var isLoad = false
    
    //backend API call for fetch adventure places by category
    func fetchPlacesByCategory(for categoryId: String, completion: @escaping ([AdventurePlace]) -> Void = {_ in}){
        
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        isLoad = true
        
        apiService.fetchAdventurePlaces(by: categoryId) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoad = false
            
            switch result{
            case .success(let places):
                self.places = places
                completion(places)
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
    
    //backend API call for fetch adventure place by ID
    func fetchPlacesByID(for id: String, completion: @escaping (AdventurePlace?) -> Void = {_ in}){
        
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        isLoad = true
        
        apiService.fetchAdventurePlace(by: id) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoad = false
            
            switch result{
            case .success(let place):
                self.placeDetail = place
                completion(place)
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
    
    //backend API call for fetch adventure place by ID
    func serchPlacesByName(query: String, completion: @escaping ([AdventurePlace]) -> Void = {_ in}){
        
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        isLoad = true
        
        guard !query.isEmpty else {
            self.places = []
            return
        }
        
       
        
        apiService.SearchAdventurePlaces(query: query) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async{
                self.isLoad = false
                
                switch result{
                case .success(let places):
                    self.places = places
                    completion(places)
                case .failure(let error):
                    switch error{
                    case .httpError(let code) where code == 401:
                        self.handleInvalidToken()
                    case .serverError(let message) where message.contains("No matching adventure sites found"):
                        self.places = []
                        completion([])
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
