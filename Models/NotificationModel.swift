//
//  NotificationModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 28/09/2025.
//

import Foundation

struct NotificationModel: Identifiable, Codable{
    let id = UUID()
    let title: String
    let message: String
    let date: Date = Date()
}
