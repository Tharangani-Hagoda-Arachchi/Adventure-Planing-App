//
//  ContentView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 18/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isLogin") private var isLogin: Bool = false
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        Group{
            if isLogin{
                MainTabView()
                
            }else{
                LoadingView()
                
            }
            
        }

    }
}

#Preview {
    ContentView()
}
