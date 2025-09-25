//
//  Package.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//


import Foundation
struct Packages:Identifiable,Codable{
    let id : String
    let name: String
    let price: Double
    let time: String
    let place: String
    let mealAvailability: String
    let description: String
    let ratings: Double
    let categoryId: String
    let packageImage: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case price
        case time
        case place
        case mealAvailability
        case description
        case ratings
        case categoryId
        case packageImage
        
        }


}
