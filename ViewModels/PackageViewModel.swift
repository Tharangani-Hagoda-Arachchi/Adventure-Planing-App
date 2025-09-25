//
//  PackageViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import Foundation
import SwiftUI

class PackageViewModel : ObservableObject{
    
    @Published var packages: [Packages] = []
    @Published var packagesDetail: Packages? = nil// for single responce
    
    //alert
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //load status
    @Published var isLoad = false
    
    private var apiService = APIServices.shared
    
    //sesion expire allert
    @Published var showSessionExpireAlert = false
    
    //backend API call for fetch all packages
    func fetchAllPackages(completion: @escaping ([Packages]) -> Void = {_ in}){
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        isLoad = true
        packages = []
        
        apiService.fetchPackages { [weak self] result in
            guard let self = self else { return }
            
            self.isLoad = false
            
            switch result{
            case .success(let packages):
                self.packages = packages
                completion(packages)
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
    
    //backend API call for fetch packages by ategory
    func fetchPackagesByCategoryName(for categoryId: String, completion: @escaping ([Packages]) -> Void = {_ in}){
        
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        isLoad = true
        packages = []
        
        apiService.fetchPackagesByCategory(by: categoryId) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoad = false
                
                switch result{
                case .success(let packages):
                    self.packages = packages
                    completion(packages)
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
    
    //backend API call for fetch adventure place by ID
    func serchPackagesByName(query: String, completion: @escaping ([Packages]) -> Void = {_ in}){
        
        guard let token = TokenManager.shared.getAcessToken() else{
            handleInvalidToken()
            return
        }
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            self.packages = []
            return
        }
        
        isLoad = true
        
        
        apiService.SearchPackages(query: trimmedQuery) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async{
                self.isLoad = false
                
                switch result{
                case .success(let packages):
                    self.packages = packages
                    completion(packages)
                case .failure(let error):
                    switch error{
                    case .httpError(let code) where code == 401:
                        self.handleInvalidToken()
                    case .serverError(let message) where message.contains("No matching packages foundratana"):
                        self.packages = []
                        completion([])
                    default:
                        self.packages = []
                        completion([])
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

