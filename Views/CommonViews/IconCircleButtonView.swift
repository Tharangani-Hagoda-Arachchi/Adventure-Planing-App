//
//  IconCircleButtonView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 17/09/2025.
//

import SwiftUI

struct IconCircleButtonView: View {
    let systemImage: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Image(systemName: systemImage)
                .font(Font.primarysBoldText)
                .foregroundColor(Color.AppPrimaryTextField)
                .frame(width: 50, height: 50)
                .background(backgroundColor)
                .cornerRadius(12)
                .shadow(radius: 3)
        }

    }
}

