//
//  PackageDetailView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI

struct PackageDetailView: View {
    let packageId: String
    @StateObject private var packageVModel = PackageViewModel()
    @StateObject private var favouriteVModel = FavouriteViewModel()
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.dismiss) private var dismiss
    
    @State private var goToBooking = false
    
    var body: some View {
        
        GeometryReader{ geometry in
            ScrollView(showsIndicators: false){
                if let detail = packageVModel.packagesDetail{
                    VStack(spacing: 0){
                        
                        ZStack(alignment: .topLeading){
                            // image
                            if let imageData = Data(base64Encoded: detail.packageImage.components(separatedBy: ",").last ?? ""),
                               let uiImage = UIImage(data: imageData){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width - 24, height: geometry.size.height * 0.35)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 6)
                                    .padding(.horizontal, 12)
                                    .padding(.top, 8)
                                
                            }
                            
                            //back button
                            
                            Button(action: {
                                dismiss()  // default back
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2.weight(.bold))
                                    .foregroundColor(Color.AppButtonText)
                                    .padding(10)
                                    .background(Color.AppPrimaryTextField.opacity(0.5))
                                    .clipShape(Circle())
                                    .padding([.top, .leading],16)
                                
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 20){
                            
                            HStack{
                                //package name
                                Text(detail.name)
                                    .font(.title2.bold())
                                    .foregroundColor(fontColor)
                                Spacer()
                                
                                //rating star
                                RatingStarView(rating: detail.ratings)
                            }
                            .padding(.horizontal,16)
                            .padding(.top,16)
                            
                            
                            HStack{
                                //duration
                                Text("Duration")
                                    .font(.cardTitleText)
                                    .foregroundColor(fontColor)
                                
                                Text(detail.time)
                                    .font(.cardText)
                                    .foregroundColor(fontColor)
                            }.padding(.horizontal,16)
                            
                            VStack(alignment: .leading, spacing: 12){
                                //price
                                Text("USD \(String(format: "%.2f", detail.price))")
                                    .font(Font.cardSubTitleText)
                                    .foregroundColor(.brown)
                                    .padding(.horizontal,16)
                                //place
                                Text(detail.place)
                                    .font(.cardText)
                                    .foregroundColor(fontColor)
                                    .padding(.horizontal,16)
                                
                                //meal availability
                                Text(detail.mealAvailability)
                                    .font(.cardText)
                                    .foregroundColor(fontColor)
                                    .padding(.horizontal,16)
                                
                                
                            }
                            
                            
                            //description
                            Text(detail.description)
                                .font(.cardSmallText)
                                .foregroundColor(fontColor)
                                .padding(.horizontal,16)
                                .lineSpacing(4)
                            
                            
                            HStack(spacing: 16){
                                //favourite
                                IconCircleButtonView(
                                    systemImage:favouriteVModel.isFavouritePackages(packageId: detail.id) ? "heart.fill" : "heart",
                                    backgroundColor: favouriteVModel.isFavouritePackages(packageId: detail.id) ? Color.red.opacity(0.2) : Color.gray.opacity(0.2)
                                ){
                                    if favouriteVModel.isFavouritePackages(packageId: detail.id){
                                        favouriteVModel.removeFavouritePackages(packageId: detail.id)
                                    }else{
                                        favouriteVModel.addFavouritePackages(packages: detail)
                                    }
                                    
                                }
                                .foregroundColor(favouriteVModel.isFavourite(placeId: detail.id) ? .red : .gray)
                                
                                //book now button
                                CustomPrimaryButtonView(title: "Reserve Now"){
                                    goToBooking = true
                                }
                                
                                // navigation to package bookings
                                NavigationLink(
                                    destination: PackageBookingView(
                                        name: detail.name,
                                        price: detail.price,
                                        time: detail.time,
                                        meal: detail.mealAvailability,
                                        package: detail,
                                        
                                    ),
                                isActive: $goToBooking,
                                label: { EmptyView() }
                                )
                                //.hidden()
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal,16)
                            .padding(.top,10)
                        }
                        .padding(.bottom,30)
                        
                    }
                } else {
                    
                    ProgressView("Loading Details...")
                        .padding()
                    
                    //alerts
                        .alert(isPresented:$packageVModel.showSessionExpireAlert){
                            Alert(
                                title: Text("Session Expired"),
                                message: Text("Please login again"),
                                dismissButton: .default(Text("OK")){
                                    DispatchQueue.main.async{
                                        TokenManager.shared.sessionLogout()
                                        //isLogin = false
                                        packageVModel.showSessionExpireAlert = false
                                        
                                    }
                                    
                                }
                            )
                        }
                    
                }
                
                
            }.onAppear{
                packageVModel.fetchPackagesById(for: packageId)
            }
            
            .navigationBarHidden(true)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    //color according to dark theam
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
}


