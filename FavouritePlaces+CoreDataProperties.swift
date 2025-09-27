//
//  FavouritePlaces+CoreDataProperties.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 27/09/2025.
//
//

import Foundation
import CoreData


extension FavouritePlaces {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePlaces> {
        return NSFetchRequest<FavouritePlaces>(entityName: "FavouritePlaces")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var openTime: String?
    @NSManaged public var placeDescription: String?
    @NSManaged public var ratings: Double
    @NSManaged public var siteImage: String?

}

extension FavouritePlaces : Identifiable {

}
