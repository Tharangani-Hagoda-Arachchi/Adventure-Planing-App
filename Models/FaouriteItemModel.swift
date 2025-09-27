//
//  FaouriteItemModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import Foundation
import CoreData

struct FavouriteItemModel: Identifiable {
    let id: String
    let name: String              
    let siteImage: String?
    let openTime: String?
    let placeDescription: String?
    let ratings: Double?
    //let email: String?
}
