//
//  PackageCardView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI

struct PackageCardView: View {
    @StateObject private var packageModel = PackageViewModel()
    let package : Packages
    
    @State private var selectedPackageId: String? = nil
    
    @State private var navigateToDetail = false
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            HStack(alignment:.top, spacing: 12){
                // if backend load image
                if let imageData = Data(base64Encoded: package.packageImage.components(separatedBy: ",").last ?? ""),
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .cornerRadius(5)
                        .shadow(radius: 4)
                } else{
                    //for default shoe profile icon
                    Rectangle()
                        .fill(Color.AppPrimary.opacity(0.2))
                        .overlay(
                            Image(systemName: "bag.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.AppPrimary)
                                .padding(20)
                        )
                        .frame(width: 100, height: 100)
                }
                
                VStack(alignment:.leading, spacing: 4){
                    HStack{
                        //name
                        Text(package.name)
                            .font(Font.cardTitleText)
                            .foregroundColor(Color.AppPrimaryTextField)
                       Spacer()
                        

                        
                    }
                    
                    
                    Text(String(format: "%.2f", package.price))
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(Color.AppPrimaryTextField)
                    
                    Text("USD \(String(format: "%.2f", package.time))")
                        .font(Font.cardSubTitleText)
                        .foregroundColor(.brown)
                    
                    Text("Category: \(package.mealAvailability)")
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(Color.AppPrimaryTextField)
                    
                    //rating
                    RatingStarView(rating: package.ratings)

                    
                }
                Spacer()
                    
            }
            Button(action: {
                packageModel.fetchPackageByID(for: package.id)
                navigateToDetail = true
            }) {
                    
                Text("Book")
                    
                    .font(Font.cardTitleText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.AppPrimary)
                    .foregroundColor(Color.AppButtonText)
                    .clipShape(Capsule())
                }
                
                //NavigationLink(
                    //destination: PackageDetailView(package: package),
                    //isActive: $navigateToDetail,
                    //label: { EmptyView() }
                //)
                .hidden()
                        
                
            
            .padding(.bottom, 12)

                
            }
            .padding()
            .background(Color.AppButtonText)
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
            .padding(.horizontal)

        
        }
        
        
    
}


