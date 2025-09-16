//
//  SmallButtonView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//

import SwiftUI


struct SmallButtonView: View {
    var title: String

    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title.capitalized)
                .font(Font.primarysBoldText)
                .foregroundColor(Color.AppPrimaryTextField)
                .frame(maxWidth:200)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background((Color.AppPrimaryTextField.opacity(0.1)))
                .cornerRadius(15)
                .shadow(radius: 4)
            
        }
        
    }
}


