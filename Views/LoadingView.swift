//
//  LoadingView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/08/2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var navigateToLogin = false
    var body: some View {
        
            NavigationStack{
                ZStack{
                    Image("Travelposter")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Spacer()
                        Button(action: {
                            navigateToLogin = true
                        }){
                            Text("Start Exploring....")
                                .font(Font.buttonLargeText)
                                .foregroundColor(Color.AppButtonText)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 14)
                                .background(Capsule().fill(Color.AppPrimary .opacity(0.27)))
                                .overlay(Capsule().stroke(Color.AppPrimary, lineWidth: 1))
                        }
                        
                        .padding(.bottom, 80)
                        
                    }
                    
                    .navigationDestination(isPresented: $navigateToLogin){
                        CreateAccountView()
                        
                    }
                  
                }
                
            }
            
        }
           
    }


#Preview {
    LoadingView()
}
