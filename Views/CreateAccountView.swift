//
//  CreateAccountView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/08/2025.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject private var registerViewModel = CreateAccountViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                
                // backgroun image section
                Rectangle()
                    .fill(ImagePaint(image: Image("RegisterBackgroundImage"), scale: 0.7))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea(.all)
                
                // BOTTEM FREAME SECTION
                VStack(spacing: 12){
                    
                    //heading and sub heading section
                    VStack{
                        Text("Register")
                            .font(Font.TitleText)
                        Text("Let's Get Started")
                            .font(Font.SubTitleText)
                        Text("Create New Account")
                            .font(Font.SubTitleSmallText)
                        
                    }
                    .padding()
                    .padding(.horizontal, 16)
                    
                    //create form using custom text field
                    VStack(spacing: 12,){
                        CustomTextFieldView(
                            icon: "person.fill", placeHolder: "Name", text: $registerViewModel.name,displayError: registerViewModel.errorName != nil
                        )
                        ErrorTextView(error: registerViewModel.errorName)
                        
                        CustomTextFieldView(
                            icon: "envelope.fill", placeHolder: "Email", text: $registerViewModel.email
                        )
                        ErrorTextView(error: registerViewModel.errorEmail)
                        
                        CustomTextFieldView(
                            icon: "phone.fill", placeHolder: "Phone No", text: $registerViewModel.phone,
                        )
                        ErrorTextView(error: registerViewModel.errorPhone)
                        
                        CustomTextFieldView(
                            icon: "lock.fill", placeHolder: "Password", isSecure: true, text: $registerViewModel.password
                        )
                        ErrorTextView(error: registerViewModel.errorPassword)
                        
                        CustomTextFieldView(
                            icon: "lock.fill", placeHolder: "Confirm Password", isSecure: true, text: $registerViewModel.confirmPassword
                        )
                        ErrorTextView(error: registerViewModel.errorConfirmPassword)
                        
                        //register button
                        VStack{
                            CustomPrimaryButtonView(title: "Register"){
                                registerViewModel.validateCreateAccount()
                                if registerViewModel.isValid{
                                    //call register functin in view model
                                    registerViewModel.useRegistration()
                                }
                            
                                    
                            }
                            .padding(.top, 20)
                            
                            HStack{
                                Text("Already have an account")
                                    .font(Font.primarysSemiboldText)
                                NavigationLink(destination: LoginView()){
                                    Text("Login")
                                        .font(Font.primarysSemiboldText)
                                        .foregroundColor(Color.AppSecondary)
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                    }
                    .padding(.bottom, 70)
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 5)
            }
            
            .alert(isPresented: $registerViewModel.showAlert){
                Alert(
                    title:Text(registerViewModel.alertTitle),
                    message: Text(registerViewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
                
            }
            
            
            
            
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    CreateAccountView()
}
