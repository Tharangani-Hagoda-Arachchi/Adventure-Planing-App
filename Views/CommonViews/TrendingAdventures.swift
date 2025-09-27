//
//  TrendingAdventures.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 27/09/2025.
//

import SwiftUI

struct TrendingAdventures: View {
    //for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    let places: [AdventurePlace]
    let topCount: Int
    
    private var topRatedPlaces: [AdventurePlace] {
         return places
             .sorted { $0.ratings > $1.ratings }
             .prefix(topCount)
             .map { $0 }
     }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16){
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 16){
                    ForEach(topRatedPlaces, id: \.id){ place in
                        TrendingAdventureCard(adventurePlace: place)
                    }
                }

            }
            .padding(.horizontal)

        }
        
    }
    
    struct TrendingAdventureCard: View {
        @AppStorage("isDarkMode") private var isDarkMode = false
        let adventurePlace: AdventurePlace

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    // Adventure place image
                    if let imageData = Data(base64Encoded: adventurePlace.siteImage.components(separatedBy: ",").last ?? ""),
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90,height: 90)
                            .clipped()
                            .cornerRadius(12)
                    }
                }
                
                Text(adventurePlace.name)
                    .font(.cardText)
                    .foregroundColor(fontColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(width: 120, alignment: .leading)
                
                RatingStarView(rating: adventurePlace.ratings)
            }.frame(width: 120)
        }
        
        //color according to dark theam
        private var fontColor: Color{
            isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
            
        }
        
    }
    

    

}
