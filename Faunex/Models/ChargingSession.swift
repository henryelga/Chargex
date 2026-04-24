import Foundation

struct ChargingSession: Codable, Identifiable {
    let id: UUID
    let stationName: String
    let startTime: Date
    let endTime: Date?
    
    var duration: TimeInterval? {
        guard let endTime = endTime else { return nil }
        return endTime.timeIntervalSince(startTime)
    }
    
    var durationString: String {
        guard let duration = duration else { return "In progress" }
        
        let minutes = Int(duration) / 60
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        return "\(hours)h \(remainingMinutes)m"
    }
}
