//
//  CustomPrimaryButtonView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct CustomPrimaryButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .font(Font.primarysBoldText)
                .foregroundColor(Color.AppButtonText)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 40)
                .padding(.vertical, 14)
                .background((Color.AppPrimary))
                .overlay(Capsule().stroke(Color.AppPrimary, lineWidth: 1))
                .cornerRadius(15)
                .shadow(radius: 4)
        }
    }
}

