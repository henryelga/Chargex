//
//  NotificationDelegate.swift
//  Faunex
//
//  Created by Student on 28/04/2026.
//

import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationDelegate()
    
    private override init() {}
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }
}
