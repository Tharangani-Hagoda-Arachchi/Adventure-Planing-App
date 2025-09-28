//
//  BookingType.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import Foundation

enum BookingType{
    case guide(Guide)
    case package(Packages)
    
    var title: String {
        switch self {
        case .guide(let guide): return guide.guideName
        case .package(let package): return package.name
        }
    }
    
    var category: String {
        switch self {
        case .guide(let guide): return guide.guideAdventureCategory
        case .package(let package): return "Package"
        }
    }
    
    var place: String {
        switch self {
        case .guide(let guide): return guide.guideAdventurePlace
        case .package(let package): return package.place
        }
    }
    
    
    var price: Double {
        switch self {
        case .guide(let guide): return guide.guideFee
        case .package(let package): return package.price
        }
    }
    
    // total price
    func totalPrice(for travelers: Int) -> Double {
        return price * Double(travelers)
    }
    
    var formattedPrice: String {
        return "USD \(String(format: "%.2f", price))"
    }
    
    func formattedTotalPrice(for travelers: Int) -> String {
        return "USD \(String(format: "%.2f", totalPrice(for: travelers)))"
    }
    
    var displaySubtitle: String {
        switch self {
        case .guide(let guide):
            return "\(guide.guideAdventureCategory) • \(guide.guideAdventurePlace)"
        case .package(let package):
            return package.place
        }
    }
    
    
    
}
