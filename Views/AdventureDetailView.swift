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
    
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    
    //for guide navigation
    @State private var navigateToGuide = false
    
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
                                    .frame(width: geometry.size.width - 24, height: geometry.size.height * 0.55)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 6)
                                    .padding(.horizontal, 12)
                                    .padding(.top, 8)
                                
                            }
                            
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
                                    .foregroundColor(Color.AppPrimaryTextField)
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
                                    .foregroundColor(Color.AppPrimaryTextField)
                                //Spacer()
                                Text(detail.openTime)
                                    .font(.cardSmallText)
                                    .foregroundColor(Color.AppPrimaryTextField)
                            }
                            .padding(.horizontal,16)
                            
                            //hire guide and package buttons
                            HStack(spacing: 16) {
                                SecondaryRoundedActionButton(title: "Packages"){
                                    //load packeges function
                                }

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
                                .foregroundColor(Color.AppPrimaryTextField)
                                .padding(.horizontal,16)
                                .lineSpacing(4)
                            
                            
                            HStack(spacing: 16){
                                //favourite
                                IconCircleButtonView(systemImage: "heart", backgroundColor: Color.red.opacity(0.2)){
                                    
                                }
                                //view location
                                IconCircleButtonView(systemImage: "location", backgroundColor: Color.yellow.opacity(0.2)){
                                    
                                }
                                Spacer()
                                
                                //add event
                                Button(action: {
                                    
                                }){
                                    Text("Shedule")
                                        .font(.headline)
                                        .foregroundColor(Color.AppButtonText)
                                        .frame(width: 150, height: 48 )
                                        .background(Color.AppPrimary)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal,16)
                            .padding(.top,10)
                        }
                        .padding(.bottom,30)
                        
                    }
                } else {
                    
                    ProgressView("Loading Details...")
                        .padding()
                }
            }.onAppear{
                adventurePlaceModel.fetchPlacesByID(for: placeId)
            }
            
            .navigationBarHidden(true)
        }
    }
}
                        


                        

                        
                        


                            



//#Preview {
    //AdventureDetailView()
//}
