//
//  PackageBookingView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 27/09/2025.
//

import SwiftUI

struct PackageBookingView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    let name: String
    let price: Double
    let time: String
    let meal: String
    
    @State private var date = Date()
    @State private var travellers = 1
    
    var body: some View {
        NavigationStack{
            VStack{
                //top navigation
                TopNavigationView(showBackButton: true)
                VStack(){
                    Text(name)
                        .font(Font.buttonLargeText)
                        .foregroundColor(fontColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
                    Text("USD \(String(format: "%.2f", price))")
                        .font(Font.primarysBoldText)
                        .foregroundColor(.brown)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    
                    Text(time)
                        .font(Font.primarysBoldText)
                        .foregroundColor(fontColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    
                    Text(meal)
                        .font(Font.primarysBoldText)
                        .foregroundColor(fontColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    
                }.padding()
                
                VStack{
                    TravelDatePickerView(selectedDate: $date, travellers: $travellers)
                        .padding()

                }
                .padding()
                
                VStack(spacing: 0){
                    Text("Total Amount")
                        .font(.cardTitleText)
                    Text("Selected Date: \(date,formatter: dateFormatter)")
                        .font(.SubTitleSmallText)
                    Text("Travellers: \(travellers)")
                        .font(.SubTitleSmallText)
                        .padding(.bottom)
                    // total price
                    Text("Total: USD \(String(format: "%.2f", price * Double(travellers)))")
                        .font(.primarysSemiboldText)
                        .foregroundColor(.brown)
                    
                        
                    
                }
                .padding()
                .background(cardbackgroundColor)
                .cornerRadius(16)
                .shadow(color: cardShadowColor, radius:5 , x:0, y: 2)
                
                //reserve now and pay later button
                CustomPrimaryButtonView(title: "Reserve Now and Pay Later"){
                    //goToBooking = true
                }
                .padding(.top, 40)
                .padding()
                
                Spacer()
                
                
                
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
         .navigationBarHidden(true)
        
    }
    
    //for format date
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    
    //color according to mode
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    private var cardbackgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.2) : Color.AppButtonText
        
    }
    
    private var cardShadowColor: Color{
        isDarkMode ? Color.AppButtonText.opacity(0.1) : Color.AppPrimaryTextField.opacity(0.4)
        
    }

}


