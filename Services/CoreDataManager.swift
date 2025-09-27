//
//  CoreDataManager.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import CoreData
import SwiftUI

class CoreDataManager{
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    private init(){
        container = NSPersistentContainer(name: "AdventurePlacesModel")
        container.loadPersistentStores{desc, error in
            if let error = error{
                print("Failed to load core data: \(error.localizedDescription)")
            }else{
                print("succesfully load core data")
                
            }
        }
    }
    
    var context: NSManagedObjectContext {container.viewContext}
    
    //add favourite adventure places
    func addPlacesToFavourite(place: AdventurePlace, email:String){
        let favourite = FavouritePlaces(context: context)
        favourite.id = place.id
        favourite.name = place.name
        favourite.siteImage = place.siteImage
        favourite.openTime = place.openTime
        favourite.placeDescription = place.description
        favourite.ratings = place.ratings
        favourite.email = email
        saveContext()
        
        
    }
    
    // fetch favourite places
    func fetchFavouritePlaces(for email: String) -> [FavouritePlaces] {
        let request: NSFetchRequest<FavouritePlaces> = FavouritePlaces.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return(try? context.fetch(request)) ?? []
    }
    
    // remove favourite places
    func removeFavouritePlaces(placeId: String, email: String){
        let request: NSFetchRequest<FavouritePlaces> = FavouritePlaces.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ AND email == %@",placeId,email)
        if let result = try? context.fetch(request), let objectToDelet = result.first {
            context.delete(objectToDelet)
            print("succesfully remove")
            saveContext()
        }
    }
    
    
    
    //add favourite adventure packages
    func addPackagesToFavourite(packages: Packages, email:String){
        print("Starting to add package: \(packages.name) for email: \(email)")
        let favouritePackage = FavouritePackage(context: context)
        favouritePackage.id = packages.id
        favouritePackage.name = packages.name
        favouritePackage.price = packages.price
        favouritePackage.time = packages.time
        favouritePackage.place = packages.place
        favouritePackage.mealAvailability = packages.mealAvailability
        favouritePackage.desc = packages.description
        favouritePackage.ratings = packages.ratings
        favouritePackage.categoryId = packages.categoryId
        favouritePackage.packageImage = packages.packageImage
        favouritePackage.email = email
        saveContext()
        
        
    }

    // fetch favourite packages
    func fetchFavouritePackages(for email: String) -> [FavouritePackage] {
        let request: NSFetchRequest<FavouritePackage> = FavouritePackage.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return(try? context.fetch(request)) ?? []
    }
    
    // remove favourite packages
    func removeFavouritePackages(packageId: String, email: String){
        let request: NSFetchRequest<FavouritePackage> = FavouritePackage.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ AND email == %@",packageId,email)
        if let result = try? context.fetch(request), let objectToDelet = result.first {
            context.delete(objectToDelet)
            print("succesfully remove")
            saveContext()
        }
    }
    
    //foe add event
    func addAdventurePlan(event: AdventureEvent, email: String) {
        let plan = Event(context: context)
        plan.id = event.id 
        plan.title = event.title
        plan.location = event.location
        plan.startDateTime = event.startDateTime
        plan.endDateTime = event.endDateTime
        plan.breakfastTime = event.breakfastTime
        plan.lunchTime = event.lunchTime
        plan.teaTime = event.teaTime
        plan.manualBreakfast = event.manualBreakfast
        plan.manualLunch = event.manualLunch
        plan.manualTea = event.manualTea
        plan.email = email
        plan.calendarId = event.calendarId
        saveContext()
    }
    
    // fetch events
    func fetchaddedEvents(for email: String) -> [Event] {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        return(try? context.fetch(request)) ?? []
    }
    
    // remove event
    func removeevent(planId: UUID, email: String){
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ AND email == %@",planId as CVarArg,email)
        if let result = try? context.fetch(request), let objectToDelet = result.first {
            context.delete(objectToDelet)
            print("succesfully remove")
            saveContext()
        }
    }
    
    

    
    
    // save context function
    func saveContext(){
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else{return}
            do{
                try context.save()
                print("succesfully added")
            } catch{
                print("Failed saving: \(error.localizedDescription)")
            }
        }
        
    }
    
}
