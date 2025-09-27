//
//  UserModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case phone
    }

}
