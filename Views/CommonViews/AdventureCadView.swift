//
//  AdventureCadView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 17/09/2025.
//

import SwiftUI

struct AdventureCadView: View {
    
    let adventurePlace: AdventurePlace
    @State private var navigateToSchedule = false
    @State private var navigateToMap = false
    //@State private var isFavourite = false
    @StateObject private var favouriteVModel = FavouriteViewModel()
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading, spacing: 8){
                ZStack(alignment: .topTrailing){
                    //image
                    if let imageData = Data(base64Encoded: adventurePlace.siteImage.components(separatedBy: ",").last ?? ""),
                       let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 160)
                            .clipped()
                            .cornerRadius(16)

                    }
                    
                    //favourite button
                    Button(action:{
                        if favouriteVModel.isFavourite(placeId: adventurePlace.id){
                            favouriteVModel.removeFavouritePlaces(placeId: adventurePlace.id)
                        }else{
                            favouriteVModel.addFavouritePlaces(place: adventurePlace)
                        }
                    }){
                        Image(systemName: favouriteVModel.isFavourite(placeId: adventurePlace.id) ? "heart.fill" : "heart")
                            .foregroundColor(favouriteVModel.isFavourite(placeId: adventurePlace.id) ? .red : favoriteIcon)
                            .padding(8)
                            .background(buttonBackgroundColor)
                            .clipShape(Circle())
                            .shadow(color: buttonShadowColor,radius: 3)
                            .padding(10)
                        
                    }
                    

                }

                
                VStack(alignment: .leading, spacing: 4){
                    
                    Text(adventurePlace.name)
                        .font(.cardTitleText)
                        .foregroundColor(fontColor)
                    
                    
                    //rating stars
                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: index < Int(adventurePlace.ratings) ? "star.fill" : "star")
                                .foregroundColor(.orange)
                                .font(.caption)
                        }

                    }
                    
                    HStack{
                        Text(adventurePlace.openTime)
                            .font(.cardSmallText)
                            .foregroundColor(fontColor)
                        
                        //navigate to location
                        NavigationLink(
                            destination: MapView(selectedPlace: adventurePlace),
                            isActive: $navigateToMap,
                            label: { EmptyView() }
                        )
                        Button(action:{
                            navigateToMap = true
                            
                        }){
                            Image(systemName: "location.fill")
                                .foregroundColor(actionIconColor)
                                .padding(8)
                                .background(buttonBackgroundColor)
                                .clipShape(Circle())
                                .shadow(color: buttonShadowColor,radius: 3)
                                .padding(10)
                            
                        }
                        
                        //navigate to shedule
                        NavigationLink(
                            destination: ScheduleEvenView(adventureName: adventurePlace.name),
                            isActive: $navigateToSchedule,
                            label: { EmptyView() }
                        )
                        //event button
                        Button(action:{
                            navigateToSchedule = true
                        }){
                            Image(systemName: "calendar.badge.plus")
                                .foregroundColor(actionIconColor)
                                .padding(8)
                                .background(buttonBackgroundColor)
                                .clipShape(Circle())
                                .shadow(color: buttonShadowColor,radius: 3)
                                .padding(10)
                            
                        }
                        
                    }
                    
                    
                }
                .padding([.horizontal, .bottom],8)
            }
            .padding()
            .background(cardbackgroundColor)
            .cornerRadius(16)
            .shadow(color: cardShadowColor, radius:5 , x:0, y: 2)
            
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)

    }
    
    //color according to mode
    private var favoriteIcon: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var buttonBackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.3) : Color.AppButtonText
        
    }
    
    private var buttonShadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.1) : Color.AppPrimaryTextField.opacity(0.3)
        
    }
    
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var actionIconColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var cardbackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.2) : Color.AppButtonText
        
    }
    
    private var cardShadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.1) : Color.AppPrimaryTextField.opacity(0.4)
        
    }
      
}


