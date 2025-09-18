//
//  ContatDetailView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import SwiftUI

struct ContatDetailView: View {
    var body: some View {
        NavigationStack{
            VStack(){
                
                //top navigation view
                TopNavigationView()
                
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
                
                VStack(spacing: 12,){
                    
                }
                
            }
        }
        
        
        
    }
}

#Preview {
    ContatDetailView()
}
