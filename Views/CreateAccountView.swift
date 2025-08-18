//
//  CreateAccountView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/08/2025.
//

import SwiftUI

struct CreateAccountView: View {
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
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 5)
            }
            
        }
        
    }
}

#Preview {
    CreateAccountView()
}
