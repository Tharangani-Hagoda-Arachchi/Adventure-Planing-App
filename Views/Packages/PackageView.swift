//
//  PackageView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/08/2025.
//

import SwiftUI

struct PackageView: View {
    @State private var selectedTab : Tab = .packages
    @StateObject private var packageModel = PackageViewModel()
    @StateObject private var adventureViewModel = AdventureViewModel()
    @State private var selectedCategoryId: String? = nil
    @State private var showPlaces = false
 
    var body: some View {
        
        NavigationStack{
            VStack(){
                //tap navigation bar
                TopNavigationView()
                
                Text("Adventure Packages")
                    .font(Font.buttonLargeText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding(.horizontal)
                
                // display adventure categories
                AdventureCategoryRaw(adventureViewModel: adventureViewModel, onCategorySelected: { categoryId in
                    
                    //select same category again then show all packages
                    if selectedCategoryId == categoryId{
                        selectedCategoryId = nil
                        packageModel.fetchAllPackages()
                        print("Fetching all packages")
                    }else{
                        selectedCategoryId = categoryId
                        packageModel.fetchPackagesByCategoryName(for: categoryId)
                        showPlaces = true
                        print("Fetching packages for category: \(categoryId)")
                    }

                }, selectedCategoryId: selectedCategoryId
            ).padding(.bottom,12)
                

                
                
                ScrollView{
                    if packageModel.isLoad{
                        VStack{
                            ProgressView("Loading")
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        }
                    }else if packageModel.packages.isEmpty{
                        Text("No packages found this category")
                            .foregroundColor(.gray)
                            .padding()
                    }else{
                        
                        LazyVStack(){
                            ForEach(packageModel.packages){ package in
                                PackageCardView(package: package)
                                
                            }
                        
                        }
                    
                    }
                }
                
                
            }.padding()
        }.onAppear{
            adventureViewModel.fetchAdventure()
            packageModel.fetchAllPackages()
            
        }
        .navigationBarHidden(true)
                

    }
                        

    
}
