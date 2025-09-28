//
//  NotificationView.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 20/08/2025.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var notificationManage = NotificationManager.shared
    
    var body: some View {
        HStack(alignment:.top, spacing: 12){
            Image(systemName: "bell.fill")
                .foregroundColor(.white)
                .padding(10)
                .background(Color.red)
                .clipped(Circle())
            
            
            VStack(alignment: .leading, spacing: 4){
                Text(notification)
            }
        }
       
    }
}

#Preview {
    NotificationView()
}
