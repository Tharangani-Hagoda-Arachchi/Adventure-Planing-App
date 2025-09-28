//
//  SearchView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 25/09/2025.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var isPresented: Bool
    @Binding var selectedTab: Tab
    @State private var searchText = ""
    
    @ObservedObject var adventurePlaceModel: AdventuePlaceViewModel
    @ObservedObject var packageModel: PackageViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
   // let onAdventureSelect: ((AdventurePlace) -> Void)? = nil
   // let onPackageSelect: ((Packages) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                //back button
                Button(action:{
                    isPresented = false
                    searchText = ""
                }){
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(fontColor)
                }
                
                Text("Search")
                    .font(.buttonLargeText)
                    .foregroundColor(fontColor)
                
                Spacer()
                
            }
            .padding()
            .background(cardbackgroundColor)
            
            // search bar
            SerchBarView(
                searchText: $searchText,
                placeholder: "Search Adventures, Packages..."
                
            )
            .padding()

            
            ScrollView{
                //show results
                if !searchText.isEmpty{
                    SearchResultView(
                        searchText: searchText,
                        adventurePlaceModel: adventurePlaceModel,
                        packageModel: packageModel,
                        onAdventureSelect: { place in
                            selectedTab = .home
                            isPresented = false
                        },
                        onPackageSelect: { package in
                            selectedTab = .packages
                            isPresented = false
                            
                        }
                    )
                    .padding(.horizontal)
                    .padding(.top, 5)
                    
                } else{
                    Spacer()
                }
                
            }

        }
        
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(cardbackgroundColor.ignoresSafeArea())
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .shadow(radius: 10)
        .preferredColorScheme(isDarkMode ? .dark : .light)

                    
        
    }
    
    private var cardbackgroundColor: Color{
        isDarkMode ? Color.AppPrimaryTextField : Color.AppButtonText
        
    }
    
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
}

//#Preview {
//    SearchView()
//}
