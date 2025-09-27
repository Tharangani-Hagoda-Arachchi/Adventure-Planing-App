//
//  FavouriteViewModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import SwiftUI

class FavouriteViewModel: ObservableObject {
    
    @Published var favouritePlaces: [FavouritePlaces] = []
    @Published var favouritePackage: [FavouritePackage] = []
    @Published var event: [Event] = []
    
    
    private var email: String
    
    init(){
        self.email = UserDefaults.standard.string(forKey: "LastRegisteredEmail") ?? ""
        loadFavouritePlaces()
        loadFavouritePackages()
        loadEvent()
        
        
    }
    
    //load favourite places
    func loadFavouritePlaces(){
        favouritePlaces = CoreDataManager.shared.fetchFavouritePlaces(for: email)
    }
    
    //ad favourite places
    func addFavouritePlaces(place: AdventurePlace){
        CoreDataManager.shared.addPlacesToFavourite(place: place, email: email)
        loadFavouritePlaces()
    }
    
    
    // remove favourite places
    func removeFavouritePlaces(placeId: String){
        CoreDataManager.shared.removeFavouritePlaces(placeId: placeId, email: email)
        loadFavouritePlaces()
    }
    
    //check place is in favourite
    func isFavourite(placeId: String) -> Bool{
        return favouritePlaces.contains{$0.id == placeId}
    }
    
    
    //load favourite places
    func loadFavouritePackages(){
        favouritePackage = CoreDataManager.shared.fetchFavouritePackages(for: email)
    }
    
    //ad favourite packages
    func addFavouritePackages(packages: Packages){
        CoreDataManager.shared.addPackagesToFavourite(packages: packages, email: email)
        loadFavouritePackages()
    }
    
    
    // remove favourite packages
    func removeFavouritePackages(packageId: String){
        CoreDataManager.shared.removeFavouritePackages(packageId: packageId, email: email)
        loadFavouritePackages()
    }
    
    //check packages is in favourite
    func isFavouritePackages(packageId: String) -> Bool{
        return favouritePackage.contains{$0.id == packageId}
    }
    
    //load event
    func loadEvent() {
        event = CoreDataManager.shared.fetchaddedEvents(for: email)
    }
    
    //add event
    func addEvent(event: AdventureEvent) {
        CoreDataManager.shared.addAdventurePlan(event: event, email: email)
        loadEvent()
    }
    
    //remove event
    func removeEvent(planId: UUID, adventurePlanerVModel: AdventurePlannerViewModel ) {
        if let savedEvent = event.first(where: { $0.id == planId }) {
            let adventureEvent = AdventureEvent(
                title: savedEvent.title ?? "",
                location: savedEvent.location ?? "",
                startDateTime: savedEvent.startDateTime ?? Date(),
                endDateTime: savedEvent.endDateTime ?? Date(),
                breakfastTime: savedEvent.breakfastTime ?? Date(),
                lunchTime: savedEvent.lunchTime ?? Date(),
                teaTime: savedEvent.teaTime ?? Date(),
                manualBreakfast: savedEvent.manualBreakfast,
                manualLunch: savedEvent.manualLunch,
                manualTea: savedEvent.manualTea,
                calendarId: savedEvent.calendarId
            )
            adventurePlanerVModel.deleteEvent(event: adventureEvent)
        }
        
        CoreDataManager.shared.removeevent(planId: planId, email: email)
        loadEvent()
    }
    
    //check available events
    func isEventSaved(planId: UUID) -> Bool {
        return event.contains { $0.id == planId }
    }
    
    
}
