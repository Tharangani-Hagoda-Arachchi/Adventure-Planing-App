//
//  SecondaryRoundedActionButton.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 17/09/2025.
//

import SwiftUI

struct SecondaryRoundedActionButton: View {
    var title: String

    var action: () -> Void
    
    var body: some View {
        
        Button(action: action){
            Text(title.capitalized)
                .font(Font.primarysBoldText)
                .foregroundColor(Color.AppPrimary)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.AppButtonText)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.AppPrimary, lineWidth: 1)
                )
            
        }
        .shadow(color: Color.AppPrimaryTextField.opacity(0.4), radius:5 , x:0, y: 2)
        
    }
}


