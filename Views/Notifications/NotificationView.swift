//
//  NotificationView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var notificationManage = NotificationManager.shared
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        
        VStack{
            if notificationManage.notifications.isEmpty{
                VStack{
                    Image(systemName: "bell.slash")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                        .padding()
                    Text("No  Notifications")
                        .foregroundColor(.gray)
                        .font(.primarysBoldText)
                    
                }
                
            }else{
                List(notificationManage.notifications){ notificatin in
                    NotificationCardView(
                        title: notificatin.title,
                        message: notificatin.message,
                        date: notificatin.date
                    )
                    .listRowSeparator(.hidden)
                }.listStyle(PlainListStyle())
            }
            
        } .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationTitle("Notifications")

    }
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
}
