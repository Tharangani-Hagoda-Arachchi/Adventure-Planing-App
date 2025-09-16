//
//  AdventureCadView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 17/09/2025.
//

import SwiftUI

struct AdventureCadView: View {
    let adventurePlace: AdventurePlace
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            ZStack(alignment: .topTrailing){
                
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
                Button(action:{}){
                    Image(systemName: "heart")
                        .foregroundColor(Color.AppPrimaryTextField)
                        .padding(8)
                        .background(Color.AppButtonText)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                        .padding(10)
                    
                }
                

            }

            
            VStack(alignment: .leading, spacing: 4){
                
                Text(adventurePlace.name)
                    .font(.cardTitleText)
                
                
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
                    
                    Button(action:{}){
                        Image(systemName: "location.fill")
                            .foregroundColor(Color.AppPrimaryTextField)
                            .padding(8)
                            .background(Color.AppButtonText)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .padding(10)
                        
                    }
                    
                    Button(action:{}){
                        Image(systemName: "calendar.badge.plus")
                            .foregroundColor(Color.AppPrimaryTextField)
                            .padding(8)
                            .background(Color.AppButtonText)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .padding(10)
                        
                    }
                    
                }
                

                
            }

            .padding([.horizontal, .bottom],8)
        }
        .padding()
        .background(Color.AppButtonText)
        .cornerRadius(16)
        .shadow(color: Color.AppPrimaryTextField.opacity(0.4), radius:5 , x:0, y: 2)
    }
}


