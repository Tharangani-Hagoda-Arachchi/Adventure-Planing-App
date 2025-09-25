//
//  SerchBarView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 25/09/2025.
//

import SwiftUI

struct SerchBarView: View {
    @Binding var searchText: String
    var placeholder: String = "Search..."
    
    var body: some View {
        HStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField(placeholder, text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
        }
        
    }
}

//#Preview {
//    SerchBarView()
//}
