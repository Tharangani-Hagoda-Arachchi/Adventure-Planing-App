//
//  NotificationManager.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 28/09/2025.
//

import Foundation
import Combine

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    private init() {}
    
    @Published var notifications: [NotificationModel] = []
    
    func addNotification(title: String, message: String){
        let newNotification = NotificationModel(title: title, message: message)
        notifications.insert(newNotification, at: 0)
    }
    
}
