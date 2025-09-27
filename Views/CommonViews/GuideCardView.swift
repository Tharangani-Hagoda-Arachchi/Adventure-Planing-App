//
//  GuideCardView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct GuideCardView: View {
    @StateObject private var guideModel = GuideViewModel()
    let guide :Guide
    
    @State private var selectedGuideId: String? = nil
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var navigateToDetail = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(alignment:.top, spacing: 12){
                // if backend load image
                if let imageData = Data(base64Encoded: guide.guideImage.components(separatedBy: ",").last ?? ""),
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.AppPrimary, lineWidth: 2))
                        .shadow(radius: 4)
                } else{
                    //for default shoe profile icon
                    Circle()
                        .fill(Color.AppPrimary.opacity(0.2))
                        .overlay(
                            Image(systemName: "person.fill")
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
                        Text(guide.guideName)
                            .font(Font.cardTitleText)
                            .foregroundColor(fontColor)
                       Spacer()
                        
                        //rating
                        RatingStarView(rating: guide.ratings)
                       
                        
                    }
                    
                    
                    Text(guide.guideAdventureCategory)
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(fontColor)
                    
                    Text("USD \(String(format: "%.2f", guide.guideFee))")
                        .font(Font.cardSubTitleText)
                        .foregroundColor(.brown)
                    
                    Text("Category: \(guide.guideCategory)")
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(fontColor)
                    
                         Text("Language: \(guide.language)")
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(fontColor)
                    
                }
                Spacer()
                    
            }
            Button(action: {
                guideModel.fetchGuideByID(for: guide.id)
                navigateToDetail = true
            }) {
                    
                Text("Hire")
                    
                    .font(Font.cardTitleText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.AppPrimary)
                    .foregroundColor(Color.AppButtonText)
                    .clipShape(Capsule())
                }
                
                NavigationLink(
                    destination: GuideDetailView(guide: guide),
                    isActive: $navigateToDetail,
                    label: { EmptyView() }
                )
                .hidden()
                        
                
            
            .padding(.bottom, 12)

                
            }
            .padding()
            .background(cardbackgroundColor)
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
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


