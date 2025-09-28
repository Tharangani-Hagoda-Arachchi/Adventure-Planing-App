//
//  BookingResponse.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 28/09/2025.
//

import Foundation

struct BookingResponse: Codable {
    let success: Bool
    let message: String
    let booking: BookingDetail?
}

struct BookingDetail: Codable {
    let id: String
    let name: String
    let email: String
    let phone: String
    let address: String
    let date: String
    let travellers: Int
    let pricePerPerson: Double
    let totalPrice: Double
    let guideId: String?
    let packageId: String?
}
