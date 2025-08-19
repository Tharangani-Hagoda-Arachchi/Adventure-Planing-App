//
//  GuideMode.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import Foundation

struct Guide: Codable, Identifiable{
    let id: String
    let guideRegno: String
    let guideName: String
    let guideFee: Double
    let guideAdventureCategory: String
    let guideCategory: String
    let language: String
    let ratings: Int
    let guideImageUrl: String


}
