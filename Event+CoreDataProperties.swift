//
//  Event+CoreDataProperties.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 27/09/2025.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var startDateTime: Date?
    @NSManaged public var endDateTime: Date?
    @NSManaged public var breakfastTime: Date?
    @NSManaged public var lunchTime: Date?
    @NSManaged public var teaTime: Date?
    @NSManaged public var manualBreakfast: Bool
    @NSManaged public var manualLunch: Bool
    @NSManaged public var manualTea: Bool
    @NSManaged public var email: String?

}

extension Event : Identifiable {

}
