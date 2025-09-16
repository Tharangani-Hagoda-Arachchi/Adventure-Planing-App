//
//  AdventurePlaceModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/09/2025.
//

import Foundation
struct AdventurePlace:Identifiable,Codable{
    let id : String
    let name: String
    let latitude: Double
    let longitude: Double
    let openTime: String
    let description: String
    let ratings: Double
    let siteImage: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case latitude
        case longitude
        case openTime
        case description
        case ratings
        case siteImage
        
        }


}
