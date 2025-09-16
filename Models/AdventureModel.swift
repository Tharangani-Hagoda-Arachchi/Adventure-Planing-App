//
//  AdventureModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//

import Foundation
struct Adventure: Identifiable, Codable {
    let id: String
    let adventureType: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case adventureType
    }

}
