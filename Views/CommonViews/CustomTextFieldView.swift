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
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var displayError: Bool = false
    
    var body: some View {
        HStack{
            //icon
            Image(systemName: icon)
                .foregroundColor(fontColor)
            
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
                        .foregroundColor(fontColor)
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
        .background(backgroundColor)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(displayError ? .red : isTextFieldFocused ? Color.accentColor : Color.AppPrimary.opacity(0.2), lineWidth: 1)
            
        )
        
        //text field focus annimation
        .animation(.easeOut(duration: 0.2), value: isTextFieldFocused)
        .preferredColorScheme(isDarkMode ? .dark : .light)
       
    }
    
    //color according to mode
    private var fontColor: Color{
        isDarkMode ? Color.gray : Color.AppPrimaryTextField.opacity(0.51)
        
    }
    
    private var backgroundColor: Color{
        isDarkMode ? Color.gray.opacity(0.2) : Color.AppPrimaryTextField.opacity(0.1)
        
    }
}

