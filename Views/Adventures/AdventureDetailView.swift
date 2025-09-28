//
//  AdventureDetailView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 17/09/2025.
//

import SwiftUI

struct AdventureDetailView: View {
    
    let placeId: String
    
    @Environment(\.dismiss) private var dismiss
    
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    @StateObject private var favouriteVModel = FavouriteViewModel()
    
    @AppStorage("isLogin") private var isLogin: Bool = false
    
    @State private var navigateToMap = false
    
    //for guide navigation
    @State private var navigateToGuide = false
    @State private var navigateToSchedule = false
    @State private var navigateToPackage = false
    
    var body: some View {
        
        GeometryReader{ geometry in
            ScrollView(showsIndicators: false){
                if let detail = adventurePlaceModel.placeDetail{
                    VStack(spacing: 0){
                        
                        ZStack(alignment: .topLeading){
                            // image
                            if let imageData = Data(base64Encoded: detail.siteImage.components(separatedBy: ",").last ?? ""),
                               let uiImage = UIImage(data: imageData){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width - 24, height: geometry.size.height * 0.45)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 6)
                                    .padding(.horizontal, 12)
                                    .padding(.top, 8)
                                
                            }
                            
                            //back button
                            
                            Button(action: {
                                dismiss()  // default back
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2.weight(.bold))
                                    .foregroundColor(Color.AppButtonText)
                                    .padding(10)
                                    .background(Color.AppPrimaryTextField.opacity(0.5))
                                    .clipShape(Circle())
                                    .padding([.top, .leading],16)
                                
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 20){
                            
                            HStack{
                                //place name
                                Text(detail.name)
                                    .font(.title2.bold())
                                    .foregroundColor(fontColor)
                                Spacer()
                                
                                //rating star
                                RatingStarView(rating: detail.ratings)
                            }
                            .padding(.horizontal,16)
                            .padding(.top,16)
                            
                            
                            HStack{
                                //open hours
                                Text("Open Hours")
                                    .font(.cardTitleText)
                                    .foregroundColor(fontColor)
                                
                                Text(detail.openTime)
                                    .font(.cardSmallText)
                                    .foregroundColor(fontColor)
                            }
                            .padding(.horizontal,16)
                            
                            //hire guide and package buttons
                            HStack(spacing: 16) {
                                SecondaryRoundedActionButton(title: "Packages"){
                                    navigateToPackage = true
                                }
                                
                                //hidden navigation link for package view with place name
                                NavigationLink(
                                    destination: PackageView(placeName: detail.name),
                                    isActive: $navigateToPackage,
                                    label: { EmptyView() }
                                    
                                )
                                
                                SecondaryRoundedActionButton(title: "Hire Guide"){
                                    navigateToGuide = true
                                    
                                }
                                
                                //hidden navigation link for guide view with place name
                                NavigationLink(
                                    destination: GuideView(placeName: detail.name),
                                    isActive: $navigateToGuide,
                                    label: { EmptyView() }
                                    
                                )
                                
                                
                            }
                            .padding(.horizontal,16)
                            
                            //description
                            Text(detail.description)
                                .font(.cardSmallText)
                                .foregroundColor(fontColor)
                                .padding(.horizontal,16)
                                .lineSpacing(4)
                            
                            
                            HStack(spacing: 16){
                                //favourite
                                IconCircleButtonView(
                                    systemImage:favouriteVModel.isFavourite(placeId: detail.id) ? "heart.fill" : "heart",
                                    backgroundColor: favouriteVModel.isFavourite(placeId: detail.id) ? Color.red.opacity(0.2) : Color.gray.opacity(0.2)
                                ){
                                    if favouriteVModel.isFavourite(placeId: detail.id){
                                        favouriteVModel.removeFavouritePlaces(placeId: detail.id)
                                    }else{
                                        favouriteVModel.addFavouritePlaces(place: detail)
                                    }
                                    
                                }
                                .foregroundColor(favouriteVModel.isFavourite(placeId: detail.id) ? .red : .gray)
                                
                                //view location
                                //navigate to location
                                NavigationLink(
                                    destination: MapView(selectedPlace: detail),
                                    isActive: $navigateToMap,
                                    label: { EmptyView() }
                                )
                                IconCircleButtonView(systemImage: "location", backgroundColor: Color.yellow.opacity(0.2)){
                                    navigateToMap = true
                                    
                                }
                                Spacer()
                                
                                //add event
                                Button(action: {
                                    navigateToSchedule = true
                                    
                                }){
                                    Text("Shedule")
                                        .font(.headline)
                                        .foregroundColor(Color.AppButtonText)
                                        .frame(width: 150, height: 48 )
                                        .background(Color.AppPrimary)
                                        .cornerRadius(12)
                                }
                                //navigate to shedule
                                NavigationLink(
                                    destination: ScheduleEvenView(adventureName: detail.name),
                                    isActive: $navigateToSchedule,
                                    label: { EmptyView() }
                                )
                            }
                            .padding(.horizontal,16)
                            .padding(.top,10)
                        }
                        .padding(.bottom,30)
                        
                    }
                } else {
                    
                    ProgressView("Loading Details...")
                        .padding()
                    
                    //alerts
                        .alert(isPresented:$adventurePlaceModel.showSessionExpireAlert){
                            Alert(
                                title: Text("Session Expired"),
                                message: Text("Please login again"),
                                dismissButton: .default(Text("OK")){
                                    DispatchQueue.main.async{
                                        TokenManager.shared.sessionLogout()
                                        isLogin = false
                                        adventurePlaceModel.showSessionExpireAlert = false
                                        
                                    }
                                    
                                }
                            )
                        }
                    
                }
                
                
            }.onAppear{
                adventurePlaceModel.fetchPlacesByID(for: placeId)
            }
            
            .navigationBarHidden(true)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
    
    //color according to dark theam
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
}













//#Preview {
//AdventureDetailView()
//}
