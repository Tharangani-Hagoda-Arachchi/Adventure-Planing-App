//
//  GuideDetailCardView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct GuideDetailCardView: View {
    let lable: String
    let value: String
    var body: some View {
        VStack(spacing:4){
            HStack(alignment: .top){
                
                Text("\(lable)")
                    .font(.cardSubTitleSmallText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(width: 120, alignment: .leading)
                
                Text(value)
                    .font(.cardSmallText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
            Divider()
                .background(Color.gray.opacity(0.3))
            
        }
        .padding(.vertical, 4)
        

        
    }
}


