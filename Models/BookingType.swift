//
//  BookingType.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import Foundation

enum BookingType{
    case guide(Guide)
    //case package(Package)
    
    var title: String {
        switch self {
        case .guide(let guide): return guide.guideName
        //case .package(let package): return package.packageName
        }
    }
    
    var category: String {
        switch self {
        case .guide(let guide): return guide.guideAdventureCategory
        //case .package(let package): return package.packageName
        }
    }
    
    var place: String {
        switch self {
        case .guide(let guide): return guide.guideAdventurePlace
        //case .package(let package): return package.packageName
        }
    }
    
    
    var price: Double {
        switch self {
        case .guide(let guide): return guide.guideFee
        //case .package(let package): return package.packagePrice
        }
    }
}
