//
//  AdventureView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/09/2025.
//

import SwiftUI

struct AdventureView: View {
    
    let categoryId: String
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    
    private let columns  = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack{
            VStack{
                //top navigation
                TopNavigationView()
                
                Text("Adventures")
                    .font(Font.buttonLargeText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
            }
            ScrollView{
                LazyVStack(spacing: 16){
                    ForEach(adventurePlaceModel.places){ place in
                        NavigationLink(destination: AdventureDetailView(placeId: place.id)) {
                            AdventureCadView(adventurePlace: place)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            
                        }
                        .buttonStyle(PlainButtonStyle()) // r

                    }
                }
                .padding(.top, 16)
            }
            .padding(.bottom,16)
            .onAppear{
                adventurePlaceModel.fetchPlacesByCategory(for: categoryId)
            }
            .navigationBarHidden(true)
            
        }
        
    }
}

//#Preview {
   // AdventureView()
//}
