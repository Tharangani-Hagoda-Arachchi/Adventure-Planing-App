//
//  ErrorTextView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct ErrorTextView: View {
    let error: String?
    
    var body: some View {
        if let error = error{
            Text(error)
                .foregroundColor(.red)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 0.5)
        }
        
    }
}


