//
//  ChargexApp.swift
//  Chargex
//
//  Created by Student on 20/03/2026.
//

import SwiftUI
import SwiftData
import UserNotifications

@main
struct ChargexApp: App {
    
    init() {
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SavedStation.self)
    }
}
