//
//  ContentView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isLogin") private var isLogin: Bool = false
    @State private var isLoading: Bool = true
    @State private var navigateToLogin: Bool = true
    
    var body: some View {
        NavigationStack{
            ZStack{
                if isLoading{
                    LoadingView()
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                isLoading = false
                            }
                            
                        }
                    
                    
                }else{
                    if isLogin {
                        MainTabView()
                    } else {
                        LoginView()
                    }
                    
                }
            }
        }
    }

    
}

#Preview {
    ContentView()
}
