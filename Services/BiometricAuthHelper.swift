//
//  BiometricAuthHelper.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//

import Foundation
import LocalAuthentication

class BiometricAuthHelper{
    static let shared = BiometricAuthHelper()
    private init() {}
    
    func authenticateWithFaceID(completion: @escaping(Bool, Error?) -> Void){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                    let reason = "Login with Face ID"
                    
                    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                        DispatchQueue.main.async {
                            completion(success, authError)
                        }
                    }
                } else {
                    completion(false, error)
                }
    }
}
