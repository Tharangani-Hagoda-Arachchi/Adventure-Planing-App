//
//  GuideView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct GuideView: View {
    @StateObject private var guideModel = GuideViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(guideModel.guides, id: \._id) { guide in
                    GuideCardView(guide:guide)
                        .padding(.horizontal)
                }
            }
        }
        .background(Color.AppButtonText.opacity(8.9).edgesIgnoringSafeArea(.all))
        .onAppear {
            guideModel.fetchGuide()
        }
        .alert(isPresented: $guideModel.showAlert) {
            Alert(title: Text(guideModel.alertTitle),
                  message: Text(guideModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    GuideView()
}
