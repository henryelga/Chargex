//
//  NotificationManager.swift
//  Faunex
//
//  Created by Student on 28/04/2026.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() {}
    
    func scheduleChargingNotification(after minutes: Int, stationName: String) {
        
        cancelChargingNotification()
        
        let content = UNMutableNotificationContent()
        content.title = "Charging Complete!"
        content.body = "\(stationName): \(minutes) minutes have passed. Check your car."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(minutes * 60),
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: "charging_complete",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelChargingNotification() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ["charging_complete"])
    }
}
