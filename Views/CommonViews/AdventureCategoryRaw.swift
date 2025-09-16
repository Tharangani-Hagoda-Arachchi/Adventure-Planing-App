//
//  AdventureCategoryRaw.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 21/08/2025.
//

import SwiftUI

struct AdventureCategoryRaw: View {
    @ObservedObject var adventureViewModel: AdventureViewModel
    var onCategorySelected: (String) -> Void
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 10){

                ForEach(adventureViewModel.adventures) { adventure in
                    SmallButtonView(title: adventure.adventureType){
                        adventureViewModel.selectAdventure(adventure)
                        onCategorySelected(adventure.id)
                        
                      
                    }
                    
                }
            }
            
        }
    }
}
