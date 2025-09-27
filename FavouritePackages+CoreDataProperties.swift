//
//  FavouritePackages+CoreDataProperties.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 27/09/2025.
//
//

import Foundation
import CoreData


extension FavouritePackages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePackages> {
        return NSFetchRequest<FavouritePackages>(entityName: "FavouritePackages")
    }

    @NSManaged public var categoryId: String?
    @NSManaged public var desc: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var mealAvailability: String?
    @NSManaged public var name: String?
    @NSManaged public var packageImage: String?
    @NSManaged public var place: String?
    @NSManaged public var price: Double
    @NSManaged public var ratings: Double
    @NSManaged public var time: String?

}

extension FavouritePackages : Identifiable {

}
