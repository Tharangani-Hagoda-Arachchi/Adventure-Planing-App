//
//  ProfileDetailView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 26/09/2025.
//

import SwiftUI

struct ProfileDetailView: View {
    @State private var isEditing: Bool = false
    @StateObject private var userModel = UserViewModel()
    let user: User
    
    @State private var editableName: String = ""
    @State private var editableEmail: String = ""
    @State private var editablePhone: String = ""
    
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                
                //top navigation view
                TopNavigationView()
                
                HStack{
                    
                    Text("Edit Profile")
                        .font(Font.buttonLargeText)
                        .foregroundColor(Color.AppPrimaryTextField)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,20)
                    
                    Spacer()
                    
                    //edit button
                    Button(action:{
                        isEditing.toggle()
                    }){
                        Text(isEditing ? "Cancel" : "Edit")
                            .foregroundColor(.blue)
                            .font(.primaryRegularText)
                    }.padding(.horizontal)
                    
                }

                
                //for default shoew profile icon
                Circle()
                    .fill(Color.AppPrimary.opacity(0.2))
                    .overlay(
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.AppPrimary)
                            .padding(20)
                    )
                    .frame(width: 200, height: 200)
                    .padding(.top, 25)
                    .padding(.bottom, 40)

                
                VStack(){
                    
                    ProfleDetailRawView(
                        label: "Name: ",
                        value: $editableName,
                        displayValue: user.name,
                        isEditing: isEditing
                    )
                    
                    ProfleDetailRawView(
                        label: "Email: ",
                        value: $editableEmail,
                        displayValue: user.email,
                        isEditing: false
                    )
                    
                    ProfleDetailRawView(
                        label: "Phone: ",
                        value: $editablePhone,
                        displayValue: user.phone,
                        isEditing: isEditing
                    )
                }.padding(20)
                
                if isEditing{
                    CustomPrimaryButtonView(title: isLoading ? "Saving..." : "Save Changes"){
                        
                        isLoading = true
                        
                        userModel.updateUserById(userId: user.id, name: editableName.isEmpty ? user.name : editableName, phone: editablePhone.isEmpty ? user.phone : editablePhone) { success, message in
                            if success{
                                isEditing = false
                                alertMessage = "Profile Updated Successfuly"
                                showAlert = true
                            }else{
                                alertMessage = message ?? "Fail update"
                                showAlert = true
                            }
                            
                        }
                        
                    }
                    .padding()
                    .disabled(isLoading)
                    
                }



                
                Spacer()
                    
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Update Profile"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                
            }

            
        }.navigationBarHidden(true)

    }
}


