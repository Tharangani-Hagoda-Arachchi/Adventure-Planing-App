//
//  TokenManager.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import Foundation

class TokenManager{
    static let shared = TokenManager()
    
    private init() {}
    
    private let accessToken = "userAccessToken"
    private let service = "AdventureAPP"
    
    func getAcessToken()-> String?{
        if let data = KeyChainHelper.shared.read(service: service, account: accessToken),
           let token = String (data: data, encoding: .utf8){
            return token
        }
        return nil
    }
    
    
    func saveAccessToken(_ token: String) {
            KeyChainHelper.shared.save(service: service, account: accessToken, data: Data(token.utf8))
    }

    func logout() {
            KeyChainHelper.shared.delete(service: service, account: accessToken)
            UserDefaults.standard.removeObject(forKey: "LastRegisteredEmail")
    }
        
   

    
}
