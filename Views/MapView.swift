//
//  MapView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import SwiftUI

import MapKit


struct MapView: View {

    
    @StateObject private var adventureModel = AdventureViewModel()
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    @State private var selectedTab : Tab = .map
    
    //let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 36.1069, longitude: -112.1129),latitudinalMeters: 1300, longitudinalMeters: 1300))
    
    @State private var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.009),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    
    var body: some View {
        
        VStack{
            
            ZStack(alignment: .top){
                
                
                
                
                Map(coordinateRegion: $mapRegion, annotationItems: adventurePlaceModel.places) { place in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
                              tint: .red)
                }
                .ignoresSafeArea()
                
                AdventureCategoryRaw(adventureViewModel: adventureModel) { categoryId in
                                adventurePlaceModel.fetchPlacesByCategory(for: categoryId) { places in
                                    if let first = places.first {
                                        mapRegion.center = CLLocationCoordinate2D(latitude: first.latitude,longitude: first.longitude)
                                    }
                                }
                            }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background( Capsule().fill(Color.white).overlay(Capsule().stroke(Color.white, lineWidth: 1)))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                

                
            }
            
        }
        
        

        .onAppear{
            adventureModel.fetchAdventure()
        }
        



                
            
        



    }
}

#Preview {
    MapView()
}

extension CLLocationCoordinate2D{
    static let DenverColorado = CLLocationCoordinate2D(latitude: 36.1069, longitude: -112.1129)
}
