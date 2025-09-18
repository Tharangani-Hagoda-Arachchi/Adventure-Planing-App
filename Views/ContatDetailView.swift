//
//  ContatDetailView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import SwiftUI

struct ContatDetailView: View {
    let bookingType: BookingType
    
    @Binding var date: Date
    @Binding var travellers: Int
    
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var address = ""
    
    @State private var navigateToPayment = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16){
                
                //top navigation view
                TopNavigationView()
           
                VStack{
                    Text("Contact Details")
                        .font(Font.buttonLargeText)
                        .foregroundColor(Color.AppPrimaryTextField)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,20)
                    Text("Step 1")
                        .font(Font.SubTitleSmallText)
                        .foregroundColor(Color.AppPrimaryTextField)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,20)
                   
                    
                }
                
                
                VStack(spacing: 0){
                    Text(bookingType.title)
                        .font(.SubTitleText)
                    Text(bookingType.category)
                        .font(.SubTitleSmallText)
                    Text(bookingType.place)
                        .font(.SubTitleSmallText)
                    Text("USD \(String(format: "%.2f", bookingType.price)) per person")
                        .font(.SubTitleSmallText)
                        
                    
                }
                .padding()
                .padding(.horizontal,12)
                .frame(height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.AppPrimary.opacity(0.5), lineWidth: 1)
                )
                
                VStack(spacing: 12,){

                    TextField("Full Name", text: $name)
                        .padding()
                        .background(Color.AppPrimaryTextField.opacity(0.1))
                        .cornerRadius(15)
                        //text field focus annimation

                    TextField("Email", text: $phone)
                        .padding()
                        .background(Color.AppPrimaryTextField.opacity(0.1))
                        .cornerRadius(15)
                    
                    TextField("Phone No", text: $name)
                        .padding()
                        .background(Color.AppPrimaryTextField.opacity(0.1))
                        .cornerRadius(15)
                    
                    TextField("Address", text: $address)
                        .padding()
                        .background(Color.AppPrimaryTextField.opacity(0.1))
                        .cornerRadius(15)
                    
                }
                .padding()
                
                CustomPrimaryButtonView(title: "Proceed to Payment") {
                    navigateToPayment = true
                }
                .padding()
                Spacer()
            }
            .navigationDestination(isPresented: $navigateToPayment) {
                PaymentView(
                    bookingType: bookingType,
                    date: date,
                    travellers: travellers,
                    name: name,
                    phone: phone,
                    address: address,
                    email: email
                )
            }
        }.navigationBarHidden(true)
        
        
        
    }
}

