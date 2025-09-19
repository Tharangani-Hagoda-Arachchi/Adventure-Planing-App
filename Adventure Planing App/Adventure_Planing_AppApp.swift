//
//  Adventure_Planing_AppApp.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 16/08/2025.
//

import SwiftUI

@main
struct Adventure_Planing_AppApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {

          ContentView()
                .preferredColorScheme(isDarkMode ?.dark: .light)
           
        }
    }
}
