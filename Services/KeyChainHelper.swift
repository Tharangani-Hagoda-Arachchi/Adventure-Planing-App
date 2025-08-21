//
//  KeyChainHelper.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//

import Foundation

import Security

class KeyChainHelper{
    // singolton instance
    static let shared = KeyChainHelper()
    
    private init() {}
    
    // function for save data to keychain
    func save(service: String, account: String, data: Data){
        
        let query: [String: Any] = [
               kSecClass as String: kSecClassGenericPassword,
               kSecAttrService as String: service,
               kSecAttrAccount as String: account,
               kSecValueData as String: data
           ]
           
        //delete old once
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    // function for read data to keychain
    func read(service: String, account: String) -> Data? {
         
        let query: [String: Any] = [
               kSecClass as String: kSecClassGenericPassword,
               kSecAttrService as String: service,
               kSecAttrAccount as String: account,
               kSecReturnData as String: true,
               kSecMatchLimit as String: kSecMatchLimitOne
           ]
           
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
    func delete(service: String, account: String){
         
        let query: [String: Any] = [
               kSecClass as String: kSecClassGenericPassword,
               kSecAttrService as String: service,
               kSecAttrAccount as String: account,
           ]
           

        SecItemDelete(query as CFDictionary)

    }
}
