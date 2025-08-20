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
                //scroll area
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(guideModel.guides, id: \._id) { guide in
                            GuideCardView(guide:guide)
                                .padding(.horizontal)
                            
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(edges: [.bottom, .top])
                .background(Color.AppButtonText.opacity(0.89))
               
                //bottem tab bar
                BottemTabBarView(selectedTab: $selectedTab)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                guideModel.fetchGuide()
            }
            .alert(isPresented: $guideModel.showAlert) {
                Alert(title: Text(guideModel.alertTitle),
                      message: Text(guideModel.alertMessage),
                      dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarTitleDisplayMode(.inline)

            
        }.navigationBarTitleDisplayMode(.inline)


    }
}

#Preview {
    GuideView()
}
