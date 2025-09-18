//
//  GuideDetailView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct GuideDetailView: View {
    
    @StateObject private var guideModel = GuideViewModel()
    
    let guide: Guide
    
    @State private var date = Date()
    @State private var travellers = 1
    
    @State private var navigateToContact = false 
    

    var body: some View {
        NavigationStack{
            GeometryReader{ geometry in
                
                VStack(){
                    
                    //top navigation view
                    TopNavigationView()

                    
                    // image
                    if let imageData = Data(base64Encoded: guide.guideImage.components(separatedBy: ",").last ?? ""),
                       let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                            .clipped()
                            //.cornerRadius(12)
                        
                    }else{
                        Rectangle()
                            .fill(Color.gray.opacity(0.4))
                            .frame(height:300)
                            .cornerRadius(12)
                            .overlay(Text("No Image")
                                .foregroundColor(.white)
                                .bold())
                    }
                    HStack {
                        Text(guide.guideName)
                            .font(.SubTitleText)
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                        RatingStarView(rating: guide.ratings)
                    }
                    .padding([.top, .bottom,.horizontal],20)
                    ScrollView{
                        LazyVStack{
                            
                            VStack(alignment: .leading, spacing: 8){
                                GuideDetailCardView(lable: "Registration No", value: guide.guideRegno)
                                GuideDetailCardView(lable: "Fee", value: "USD \(String(format: "%.2f", guide.guideFee))")
                                GuideDetailCardView(lable: "Category", value: guide.guideCategory)
                                GuideDetailCardView(lable: "Adventure Type", value: guide.guideAdventureCategory)
                                GuideDetailCardView(lable: "Place", value: guide.guideAdventurePlace)
                                GuideDetailCardView(lable: "Language", value: guide.language)
                                GuideDetailCardView(lable: "Validity", value: guide.guideValidity)
                                GuideDetailCardView(lable: "Phone", value: guide.guidePhoneNo)
                                GuideDetailCardView(lable: "Email", value: guide.guideEmail)
                                GuideDetailCardView(lable: "Address", value: guide.guideAddress)
                            }
                            Spacer()
                        }
                        
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
                        .padding(.horizontal)
                    }
                    VStack{
                        TravelDatePickerView(selectedDate: $date, travellers: $travellers)
                            .padding()
                        CustomPrimaryButtonView(title: "Hire Now"){
                            navigateToContact = true
                            
                        }


                    }
                    .padding()

                    
                }
                
            }
            .navigationDestination(isPresented: $navigateToContact) {
                ContatDetailView(
                    bookingType: .guide(guide),
                    date: $date,
                    travellers: $travellers
                )
            }
            
        }
        .navigationBarHidden(true)
        

        
        
    }
}

//#Preview {
   // GuideDetailView()
//}
