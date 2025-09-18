//
//  GuideView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct GuideView: View {
@State private var selectedTab : Tab = .none
@StateObject private var guideModel = GuideViewModel()
    
let placeName: String
    
var body: some View {
    NavigationStack{
        VStack(spacing: 12){
            //tap navigation bar
            TopNavigationView()
            
            Text("Hire Guide")
                .font(Font.buttonLargeText)
                .foregroundColor(Color.AppPrimaryTextField)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,20)
            
            Group{
                if guideModel.isLoad{
                    
                    ProgressView("Loading Details...")
                        .padding()
                } else if guideModel.guides.isEmpty{
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("No guides available for this place.")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else{
                    
                    //scroll area
                    ScrollView(showsIndicators: false) {
                        
                        LazyVStack(spacing: 16) {
                            ForEach(guideModel.guides) { guide in
                                
                                GuideCardView(guide:guide)
                                    .padding(.horizontal)
                            }
                            
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(edges: [.bottom, .top])
                        .background(Color.AppButtonText.opacity(0.89))
                        
                        
                    }
                }
            }
            
        }
        .onAppear {
            guideModel.fetchGuide(for: placeName)
        }
        .alert(isPresented: $guideModel.showAlert) {
            Alert(title: Text(guideModel.alertTitle),
                  message: Text(guideModel.alertMessage),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
    .navigationBarHidden(true)


    }
}

//#Preview {
   // GuideView()
//}
