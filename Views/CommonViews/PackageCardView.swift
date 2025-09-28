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
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var favouriteVModel = FavouriteViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(alignment:.top, spacing: 16){
                // if backend load image
                if let imageData = Data(base64Encoded: package.packageImage.components(separatedBy: ",").last ?? ""),
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: .infinity, height: 190)
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
                
            }

            VStack(alignment:.leading){
                HStack(){
                    //name
                    Text(package.name)
                        .font(Font.cardTitleText)
                        .foregroundColor(fontColor)
                    Spacer()
                    //favourite button
                    Button(action:{
                        if favouriteVModel.isFavouritePackages(packageId: package.id){
                            favouriteVModel.removeFavouritePackages(packageId: package.id)}
                        else{                                favouriteVModel.addFavouritePackages(packages: package)
                        }
                    }){
                        Image(systemName: favouriteVModel.isFavouritePackages(packageId: package.id) ? "heart.fill" : "heart")
                            .foregroundColor(favouriteVModel.isFavouritePackages(packageId: package.id) ? .red : favoriteIcon)
                            .padding(8)
                            .background(buttonBackgroundColor)
                            .clipShape(Circle())
                            .shadow(color: buttonShadowColor ,radius: 3)
                            .padding(10)
                        
                    }
                    
                    
                }
                
                //rating
                RatingStarView(rating: package.ratings)
                    .padding(.bottom)
                
                Text("USD \(String(format: "%.2f", package.price))")
                    .font(Font.cardSubTitleText)
                    .foregroundColor(.brown)
                
                
                Text("Duration: \(package.time)")
                    .font(Font.cardSmallText)
                    .foregroundColor(fontColor)
                
                
                Text((package.mealAvailability))
                    .font(Font.cardSmallText)
                    .foregroundColor(fontColor)
                
                Button(action: {
                    //packageModel.fetchPackageByID(for: package.id)
                    navigateToDetail = true
                }) {
                    
                    Text("Book")
                    
                        .font(Font.cardTitleText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .frame(width: 150)
                        .background(Color.AppPrimary)
                        .foregroundColor(Color.AppButtonText)
                        .clipShape(Capsule())
                }.padding(.vertical)
                
                
            }
            //Spacer()
            
            // navigation to package details
            NavigationLink(
                destination: PackageDetailView(packageId: package.id),
            isActive: $navigateToDetail,
            label: { EmptyView() }
            )
            //.hidden()
            
            
            
            .padding(.bottom, 12)
            
            
        }.preferredColorScheme(isDarkMode ? .dark : .light)
            .padding()
            .background(cardbackgroundColor)
            .cornerRadius(15)
            .shadow(color: cardShadowColor, radius: 5, x: 0, y: 2)
            .padding(.horizontal)
        
        
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


