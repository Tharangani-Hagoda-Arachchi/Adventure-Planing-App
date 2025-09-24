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
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 12){
                //tap navigation bar
                TopNavigationView()
                
                Text("Adventure Packages")
                    .font(Font.buttonLargeText)
                    .foregroundColor(Color.AppPrimaryTextField)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)
                
                ScrollView{
                    LazyVStack(spacing: 12){
                        ForEach(packageModel.packages){ package in
                            PackageCardView(package: package)
                            
                        }
                    }
                }
                
                
            }
        }.onAppear{
            packageModel.fetchPackages()
        }
                

    }
                        

    
}
