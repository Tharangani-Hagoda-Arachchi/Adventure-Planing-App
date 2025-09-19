//
//  ProfileRawView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI

struct ProfileRawView: View {
    let icon: String
    let title: String
    var isToggle: Bool = false
    @Binding var toggleValue: Bool
    var action: (() -> Void)? = nil
    
    var body: some View {

            HStack{
                Image(systemName: icon)
                    .frame(width: 24, height:24)
                
                Text(title)
                    .font(.cardSubTitleText)
                
                Spacer()
                if isToggle {
                    Toggle("", isOn: $toggleValue).labelsHidden()
                 } else {
                    Image(systemName: "chevron.right")
                 }

            }
            .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        if !isToggle {
                            action?()
                        }
                    }
        Divider()
            .background(Color.gray.opacity(0.3))
        


    }
}

