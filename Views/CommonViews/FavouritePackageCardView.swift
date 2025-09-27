//
//  FavouritePackageCardView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 27/09/2025.
//

import SwiftUI

struct FavouritePackageCardView: View {
    
    let package: FavouritePackage
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 12){
            
            //  load image
            if let base64String = package.packageImage{
                let cleanBase64 = base64String
                    .replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
                    .replacingOccurrences(of: "data:image/png;base64,", with: "")
                if let imageData = Data(base64Encoded: cleanBase64),
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 4)
                } else{
                    //for default show  icon
                    Circle()
                        .fill(Color.AppPrimary.opacity(0.2))
                        .overlay(
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.AppPrimary)
                                .padding(20)
                        )
                        .frame(width: 100, height: 100)
                }
            }
            
            //other details
            VStack(alignment:.leading, spacing: 4){
                HStack{
                    //name
                    Text(package.name ?? "unknown place")
                        .font(Font.cardTitleText)
                        .foregroundColor(fontColor)
                    Spacer()
                    
                    
                }
                //rating
                RatingStarView(rating: package.ratings)
                
                //place
                Text(package.place ?? "")
                    .font(Font.cardText)
                    .foregroundColor(fontColor)
                //price
                Text("USD " + String(format: "%.2f", package.price))
                    .font(Font.cardText)
                    .foregroundColor(fontColor)
                
            }
            
            Spacer()
            
        }
        .padding()
        .background(cardbackgroundColor)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.6), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    
    }
    
    //color change according to theme
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var cardbackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.2) : Color.AppButtonText
        
    }
}

