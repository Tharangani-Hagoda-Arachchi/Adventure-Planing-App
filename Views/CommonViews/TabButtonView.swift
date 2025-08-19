//
//  TabButtonView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import SwiftUI

struct TabButtonView: View {
    let systemImage: String
    let title: String
    let isSelect: Bool
    let action: () -> Void
    
    var body: some View {
        VStack{
            Image(systemName: systemImage)
                .font(Font.primaryRegularText)
                .foregroundColor(isSelect ? Color.AppSecondary : Color.black)
            Text(title)
                .font(.caption)
                .foregroundColor(isSelect ? Color.AppSecondary : Color.black)
        }

        .padding(.vertical,10)
        .frame(maxWidth: .infinity)
        //.background(isSelect ? Color.AppSecondary.opacity(0.5) : Color.clear)
        .onTapGesture {
            action()
        }
        
    }
}

