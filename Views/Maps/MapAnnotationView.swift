//
//  MapAnnotationView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import SwiftUI
import MapKit

struct MapAnnotationView: View {
    
    let place: AdventurePlace
    let fontColor: Color
    let markerColor: Color
    let onLookAround: () -> Void
    let onGetDirection: () -> Void
    
    var body: some View {
        
        VStack(spacing: 4) {
            Image(systemName: "location")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .padding(7)
                .background(.blue.gradient, in: .circle)
            
            Text(place.name)
                .font(.cardSmallText)
                .foregroundColor(fontColor)
                .padding(4)
                .background(markerColor)
                .cornerRadius(5)
                .contextMenu {
                    Button("Open Look Around", systemImage: "binoculars") {
                        onLookAround()

                    }
                    
                    Button("Get Direction", systemImage: "arrow.turn.down.right") {
                        onGetDirection()
                        
                    }
                }
        }
        
    }
}

