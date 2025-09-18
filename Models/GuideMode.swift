//
//  GuideMode.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import Foundation

struct Guide: Identifiable, Codable{
    let id: String
    let guideRegno: String
    let guideName: String
    let guideFee: Double
    let guideAdventureCategory: String
    let guideAdventurePlace: String
    let guideCategory: String
    let language: String
    let ratings: Double
    let guidePhoneNo: String
    let guideEmail: String
    let guideAddress: String
    let guideValidity: String
    let guideImage: String
    
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case guideRegno
        case guideName
        case guideFee
        case guideAdventureCategory
        case guideAdventurePlace
        case guideCategory
        case language
        case ratings
        case guidePhoneNo
        case guideEmail
        case guideAddress
        case guideValidity
        case guideImage

        
        }
    
    

    


}
