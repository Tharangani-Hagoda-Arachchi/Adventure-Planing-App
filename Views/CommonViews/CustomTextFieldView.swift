//
//  CustomTextFieldView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/08/2025.
//

import SwiftUI

struct CustomTextFieldView: View {
    var icon: String
    var placeHolder: String
    var isSecure: Bool = false

    
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var displayError: Bool = false
    
    var body: some View {
        HStack{
            //icon
            Image(systemName: icon)
                .foregroundColor(Color.AppPrimaryTextField.opacity(0.51))
            
            // for scure text fields (passwords)
            if isSecure{
                
                // for password visibility
                Group{
                    if isPasswordVisible{
                        TextField(placeHolder, text: $text)
                            .focused($isTextFieldFocused)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                    }else{
                        SecureField(placeHolder, text: $text)
                            .focused($isTextFieldFocused)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                    }
                }
                
                //password visible togle button
                Button(action: {
                    isPasswordVisible.toggle()
                    isTextFieldFocused = true
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(Color.AppPrimaryTextField.opacity(0.51))
                }
            } else{
                TextField(placeHolder, text: $text)
                    .focused($isTextFieldFocused)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
            }
        }
        .padding()
        .background(Color.AppPrimaryTextField.opacity(0.1))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(displayError ? .red : isTextFieldFocused ? Color.accentColor : Color.AppPrimary.opacity(0.2), lineWidth: 1)
            
        )
        
        //text field focus annimation
        .animation(.easeOut(duration: 0.2), value: isTextFieldFocused)
       
    }
}

