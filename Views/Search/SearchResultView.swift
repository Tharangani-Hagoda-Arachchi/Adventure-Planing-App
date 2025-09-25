//
//  SearchResultView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 25/09/2025.
//

import SwiftUI

struct SearchResultView: View {
    
    let searchText: String
    
    @ObservedObject  var adventurePlaceModel: AdventuePlaceViewModel
    @ObservedObject  var packageModel:  PackageViewModel
    
    let onAdventureSelect: (AdventurePlace) -> Void
    let onPackageSelect: (Packages) -> Void
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 12){
                
                if adventurePlaceModel.isLoad || packageModel.isLoad{
                    ProgressView("Searching...")
                        .padding()
                } else if  adventurePlaceModel.places.isEmpty && packageModel.packages.isEmpty && !searchText.isEmpty{
                    
                    Text("No result found")
                        .foregroundColor(.gray)
                        .font(.cardSubTitleText)
                        .padding(.top, 40)
                        .frame(maxWidth: .infinity)
                }else{
                    
                    // for adventure result
                    if !adventurePlaceModel.places.isEmpty{
                        VStack(alignment: .leading, spacing: 8){
                            VStack{
                                Text("Adventure Places")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 5)
                                
                                ForEach(adventurePlaceModel.places, id: \.id){ adventure in
                                    Button(action: {
                                        onAdventureSelect(adventure)
                                    }){
                                        HStack(spacing: 12){
                                            
                                            if let imageData = Data(base64Encoded: adventure.siteImage.components(separatedBy: ",").last ?? ""),
                                               let uiImage = UIImage(data: imageData){
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 90, height: 90)
                                                    .cornerRadius(8)
                                                    .shadow(radius: 4)
                                            } else{
                                                //for default show bag icon
                                                Rectangle()
                                                    .fill(Color.AppPrimary.opacity(0.2))
                                                    .overlay(
                                                        Image(systemName: "bag.fill")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(.AppPrimary)
                                                            .padding(20)
                                                    )
                                                    .frame(width: 60, height: 60)
                                            }
                                            
                                            Text(adventure.name)
                                                .foregroundColor(Color.AppPrimaryTextField)
                                                .font(.cardSubTitleText)
                                                //.lineLimit(2)
                                            
                                            Spacer()

                                        }
                                        .padding()
                                        .background(Color.AppButtonText)
                                        .cornerRadius(12)
                                        .shadow(color: Color.AppPrimaryTextField.opacity(0.05), radius: 4, x: 0, y: 2 )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            
                        }

                    }
                    
                    
                    
                    // for package result
                    if !packageModel.packages.isEmpty{
                        VStack(alignment: .leading, spacing: 8){
                            VStack{
                                Text("Packages")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                ForEach(packageModel.packages, id: \.id){ package in
                                    Button(action: {
                                        onPackageSelect(package)
                                    }){
                                        HStack(spacing: 12){
                                            
                                            if let imageData = Data(base64Encoded: package.packageImage.components(separatedBy: ",").last ?? ""),
                                               let uiImage = UIImage(data: imageData){
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 90, height: 90)
                                                    .cornerRadius(8)
                                                    .shadow(radius: 4)
                                            } else{
                                                //for default shoe profile icon
                                                Rectangle()
                                                    .fill(Color.AppPrimary.opacity(0.2))
                                                    .overlay(
                                                        Image(systemName: "bag.fill")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(.AppPrimary)
                                                            .padding(20)
                                                    )
                                                    .frame(width: 60, height: 60)
                                            }
                                            
                                            Text(package.name)
                                                .foregroundColor(Color.AppPrimaryTextField)
                                                .font(.cardSubTitleText)
                                                //.lineLimit(2)
                                            Spacer()

                                        }
                                        .padding()
                                        .background(Color.AppButtonText)
                                        .cornerRadius(12)
                                        .shadow(color: Color.AppPrimaryTextField.opacity(0.05), radius: 4, x: 0, y: 2 )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                }
                            }
                            
                        }

                    }
                    
                }
                
            }
        }
        .onChange(of: searchText){ newValue in
            let query = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if !query.isEmpty{
                adventurePlaceModel.serchPlacesByName(query: query)
                packageModel.serchPackagesByName(query: query)
            } else{
                adventurePlaceModel.places = []
                packageModel.packages = []
            }
            
        }
    }
}

//#Preview {
//SearchResultView()
//}
