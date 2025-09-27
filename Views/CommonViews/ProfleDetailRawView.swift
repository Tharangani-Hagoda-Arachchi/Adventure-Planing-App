//
//  ProfleDetailRawView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import SwiftUI

struct ProfleDetailRawView: View {
    
    let label : String
    @Binding var value: String
    let displayValue : String
    let isEditing: Bool
  
    
    var body: some View {
        HStack(alignment: .center, spacing: 25){
            Text(label)
                .font(.primarysBoldText)
                .foregroundColor(.AppPrimaryTextField)
                .frame(width: 60, alignment: .leading)
            
            if isEditing && label != "Email:"{
                TextField("", text: $value)
                    .font(.primarysSemiboldText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.7)))
            }else{
                Text(displayValue)
                    .font(.primarysBoldText)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }

        }
        Divider()
            .background(Color.gray)
            .padding(.bottom,40)
        
    }
}


