//
//  FavouriteView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct FavouriteView: View {
    //for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var favouriteVModel = FavouriteViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack{
            //section picker
            VStack{
                
                //top navigation view
                TopNavigationView(showBackButton: true)
                
                Text("Favourites")
                    .font(Font.buttonLargeText)
                    .foregroundColor(fontColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Picker("Favourite Type", selection: $selectedTab){
                    Text("Places").tag(0)
                    Text("Packages").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            
            //for places
            if selectedTab == 0{
                if favouriteVModel.favouritePlaces.isEmpty{
                    VStack{
                        Image(systemName: "heart.slash")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                            .padding()
                        Text("No favourite places")
                            .foregroundColor(.gray)
                            .font(.primarysBoldText)
                        Spacer()
                    }
                } else{
                    List{
                        ForEach(favouriteVModel.favouritePlaces, id: \.self){ place in
                            FavouriteCardView(place: place)
                        }
                        //delete
                        .onDelete{ indexSet in
                            indexSet.forEach{ index in
                                let place = favouriteVModel.favouritePlaces[index]
                                if let placeId = place.id{
                                    favouriteVModel.removeFavouritePlaces(placeId: placeId)
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
            }
            // for packages
            else{
                
                if favouriteVModel.favouritePackage.isEmpty{
                    VStack{
                        Image(systemName: "heart.slash")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                            .padding()
                        Text("No favourite places")
                            .foregroundColor(.gray)
                            .font(.primarysBoldText)
                        Spacer()
                    }
                } else{
                    List{
                        ForEach(favouriteVModel.favouritePackage, id: \.self){ package in
                            FavouritePackageCardView(package: package)
                        }
                        //delete
                        .onDelete{ indexSet in
                            indexSet.forEach{ index in
                                let package = favouriteVModel.favouritePackage[index]
                                if let packageId = package.id{
                                    favouriteVModel.removeFavouritePackages(packageId: packageId)
                                    
                                }
                                
                            }
                            
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
            }
            
            
        }.navigationBarHidden(true)
         .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
    //color according to dark theam
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    
}

#Preview {
    FavouriteView()
}
