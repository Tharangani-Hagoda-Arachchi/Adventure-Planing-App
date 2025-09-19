//
//  AdventureSheduleEventModel.swift
//  Adventure Planing App
//
//  Created by Tharangani Hagoda Arachchi on 19/09/2025.
//

import Foundation

struct AdventureEvent: Identifiable{
    let id = UUID()
    let title: String
    let location: String
    let startDateTime: Date
    let endDateTime: Date
    let breakfastTime: Date
    let lunchTime: Date
    let teaTime: Date
    let manualBreakfast: Bool
    let manualLunch : Bool
    let manualTea: Bool
}
