//
//  LoginView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                
                
                // backgroun image section
                Rectangle()
                    .fill(ImagePaint(image: Image("Login Background"), scale: 0.65))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea(.all)
                
                // BOTTEM FREAME SECTION
                VStack(spacing: 12){
                    
                    //heading and sub heading section
                    VStack{
                        Text("Login")
                            .font(Font.TitleText)
                        Text("Let's Get Started")
                            .font(Font.SubTitleText)
                        Text("Log Your Account")
                            .font(Font.SubTitleSmallText)
                        
                    }
                    .padding()
                    .padding(.horizontal, 16)
                    
                    //create form using custom text field
                    VStack(spacing: 12,){
                        
                        CustomTextFieldView(
                            icon: "envelope.fill", placeHolder: "Email", text: $loginViewModel.email
                        )
                        ErrorTextView(error: loginViewModel.errorEmail)
                        
                        CustomTextFieldView(
                            icon: "lock.fill", placeHolder: "Password", isSecure: true, text: $loginViewModel.password
                        )
                        ErrorTextView(error: loginViewModel.errorPassword)
                        
                        //login button
                        VStack{
                            CustomPrimaryButtonView(title: "Login"){
                                loginViewModel.validateLoginAccount()
                                if loginViewModel.isValid{
                                    //call register functin in view model
                                    loginViewModel.useLogin()

                                }
                            }
                            .alert(isPresented: $loginViewModel.showAlert) {
                                Alert(title: Text(loginViewModel.alertTitle),
                                      message: Text(loginViewModel.alertMessage),
                                      dismissButton: .default(Text("OK")))
                            }
                            //navigate to home
                            .background(
                                NavigationLink(destination: MainTabView(), isActive:$loginViewModel.isLogin){
                                    EmptyView()
                                }
                            )

                            
                            .padding(.top, 20)

                            
                            NavigationLink(destination: PasswodRecoveryIView()){
                                Text("Forget Password?")
                                    .font(Font.primarysSemiboldText)
                                    .foregroundColor(Color.AppSecondary)
                                
                            }
                            
                            HStack{
                                Text("Create new account")
                                    .font(Font.primarysSemiboldText)
                                NavigationLink(destination: CreateAccountView()){
                                    Text("Register")
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
            
            
        }
        .navigationBarHidden(true)
        // call auto face login function when appear
        .onAppear{
            loginViewModel.autoFaceIDLogin()
        }
            
        }
        
    
}

#Preview {
    LoginView()
}
