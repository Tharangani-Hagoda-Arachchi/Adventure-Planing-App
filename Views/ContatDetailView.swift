//
//  ContatDetailView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import SwiftUI

struct ContatDetailView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    let bookingType: BookingType
    
    @Binding var date: Date
    @Binding var travellers: Int
    
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var address = ""
    
    //@State private var navigateToPayment = false
    @FocusState private var isTextFieldFocused: Bool
    
    @StateObject private var bookingVM: BookingViewModel
    
    //initializer to pass data to view model
    init(bookingType: BookingType, date: Binding<Date>, travellers: Binding<Int>) {
        self.bookingType = bookingType
        _date = date
        _travellers = travellers
        _bookingVM = StateObject(wrappedValue: BookingViewModel(
            bookingType: bookingType,
            date: date.wrappedValue,
            travellers: travellers.wrappedValue
        ))
    }
    
    var body: some View {
        
        VStack(spacing: 16){
            
            //top navigation view
            TopNavigationView(showBackButton: true)
            
            
            VStack{
                Text("Contact Details")
                    .font(Font.buttonLargeText)
                    .foregroundColor(fontColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
                Text("Step 1")
                    .font(Font.SubTitleSmallText)
                    .foregroundColor(fontColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
                
                
            }
            
            
            VStack(spacing: 12){
                Text(bookingType.title)
                    .font(.SubTitleText)
                    .foregroundColor(fontColor)
                
                Text(bookingType.displaySubtitle)
                    .font(.SubTitleSmallText)
                    .foregroundColor(fontColor.opacity(0.8))
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 8){
                    HStack{
                        Text("Date")
                            .font(.SubTitleSmallText)
                            .foregroundColor(fontColor)
                        Spacer()
                        Text("\(date, formatter: dateFormatter)")
                            .font(.SubTitleSmallText)
                            .foregroundColor(fontColor)
                    }
                    
                    HStack{
                        Text("Travellers")
                            .font(.SubTitleSmallText)
                            .foregroundColor(fontColor)
                        Spacer()
                        Text("\(travellers)")
                            .font(.SubTitleSmallText)
                            .foregroundColor(fontColor)
                    }
                    
                    Divider()
                        .background(fontColor)
                    
                    
                    
                    HStack{
                        Text("Price Per Person")
                            .font(.SubTitleSmallText)
                            .foregroundColor(fontColor)
                        Spacer()
                        Text(bookingType.formattedPrice)
                            .font(.SubTitleSmallText)
                            .foregroundColor(fontColor)
                    }
                    
                    
                    HStack{
                        Text("Total Amount")
                            .font(.SubTitleSmallText)
                            .foregroundColor(fontColor)
                        Spacer()
                        Text(bookingType.formattedTotalPrice(for: travellers))
                            .font(.cardTitleText)
                            .foregroundColor(.brown)
                    }
                }
                .padding(.top,4)
                
            }
            .frame(width: 280, height: .infinity)
            .padding(.horizontal,20)
            .padding()
            .background(cardbackgroundColor)
            .cornerRadius(16)
            .shadow(color: cardShadowColor, radius:5 , x:0, y: 2)
            
            
            VStack(spacing: 12,){
                
                CustomTextFieldView(
                    icon: "", placeHolder: "Full Name", isSecure: false, text: $bookingVM.name
                )
                ErrorTextView(error: bookingVM.errorName)

                CustomTextFieldView(
                    icon: "", placeHolder: "Email", isSecure: false, text: $bookingVM.email
                )
                ErrorTextView(error: bookingVM.errorEmail)

                
                CustomTextFieldView(
                    icon: "", placeHolder: "Phone Number", isSecure: false, text: $bookingVM.phone
                )
                ErrorTextView(error: bookingVM.errorPhone)

                CustomTextFieldView(
                    icon: "", placeHolder: "Address", isSecure: false, text: $bookingVM.address
                )
                ErrorTextView(error: bookingVM.errorAddress)

                
            }
            .padding(.horizontal,20)
            .padding(.top, 4)
            
            CustomPrimaryButtonView(title: "Confirm Booking") {
                bookingVM.saveBookings()
            }
            .padding()
            Spacer()
        }
        .navigationBarHidden(true)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
        //show alert
        .alert(isPresented: $bookingVM.showAlert) {
            Alert(
                title: Text(bookingVM.alertTitle),
                message: Text(bookingVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
        
    }
    
    //for format date
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
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

