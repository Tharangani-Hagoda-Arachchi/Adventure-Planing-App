//
//  DarkTheme.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import SwiftUI

struct DarkTheme: ViewModifier {
    @Binding var isDarkMode: Bool
    func body(content: Content) -> some View{
            content
                .foregroundColor(isDarkMode ? .white : .black)
                .background(isDarkMode ? Color.black : Color.white)
                .ignoresSafeArea()
        
    }

}
extension View {
    func darkTheme(isDarkMode: Binding<Bool>) -> some View {
        self.modifier(DarkTheme(isDarkMode: isDarkMode))
    }
}
