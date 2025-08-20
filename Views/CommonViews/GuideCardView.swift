//
//  GuideCardView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct GuideCardView: View {
    let guide :Guide
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(alignment:.top, spacing: 12){
                // if backend load image
                if let imageData = Data(base64Encoded: guide.guideImage.components(separatedBy: ",").last ?? ""),
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
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
                
                VStack(alignment:.leading, spacing: 6){
                    HStack{
                        //name
                        Text(guide.guideName)
                            .font(Font.cardTitleText)
                            .foregroundColor(Color.AppPrimaryTextField)
                        Spacer()
                        
                        //rating
                        HStack(spacing: 2) {
                            ForEach(0..<3) { _ in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(.orange)
                            }
                        }
                        
                    }
                    
                    
                    Text(guide.guideAdventureCategory)
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(Color.AppPrimaryTextField)
                    
                    Text("LKR \(String(format: "%.2f", guide.guideFee))")
                        .font(Font.cardSubTitleText)
                        .foregroundColor(.brown)
                    
                    Text("ategory: \(guide.guideCategory)")
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(Color.AppPrimaryTextField)
                    
                         Text("Language: \(guide.language)")
                        .font(Font.cardSubTitleSmallText)
                        .foregroundColor(Color.AppPrimaryTextField)
                    
                }
                Spacer()
                    
            }

                
                Button(action: {
                    // Hire action
                }) {
                    Text("Hire")
                        .font(Font.cardTitleText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Color.AppPrimary)
                        .foregroundColor(Color.AppButtonText)
                        .clipShape(Capsule())
                }
               
                .padding(.bottom, 12)
                
            }
            .padding()
            .background(Color.AppButtonText)
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
            .padding(.horizontal)




                

        
        }


}


