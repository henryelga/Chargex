//
//  SessionController.swift
//  Faunex
//
//  Created by Student on 24/04/2026.
//

import Foundation
import Combine

class SessionController: ObservableObject {
    
    @Published var sessions: [ChargeSession] = []
    
    func addSession(stationName: String, latitude: Double, longitude: Double) {
        let newSession = ChargeSession(
            date: Date(),
            stationName: stationName,
            latitude: latitude,
            longitude: longitude
        )
        sessions.append(newSession)
    }
    
    var totalCharges: Int {
        sessions.count
    }
    
    var chargesThisWeek: Int {
        let calendar = Calendar.current
        return sessions.filter {
            calendar.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear)
        }.count
    }
    
    var co2Saved: Double {
        Double(sessions.count) * 2.6
    }
    
    var weeklyChartData: [(Date, Int)] {
        let calendar = Calendar.current
        
        let grouped = Dictionary(grouping: sessions) {
            calendar.startOfDay(for: $0.date)
        }
        
        return grouped
            .map { ($0.key, $0.value.count) }
            .sorted { $0.0 < $1.0 }
    }
    
    var mostUsedStations: [(String, Int)] {
        let grouped = Dictionary(grouping: sessions) { $0.stationName }
        
        return grouped
            .map { ($0.key, $0.value.count) }
            .sorted { $0.1 > $1.1 }
    }
}
