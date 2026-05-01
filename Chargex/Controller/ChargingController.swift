import Foundation
import Combine

class ChargingController: ObservableObject {
    
    @Published var activeSession: ChargingSession?
    @Published var sessions: [ChargingSession] = []
    
    @Published var liveDuration: TimeInterval = 0

    private var timer: Timer?
    
    private let store = ChargingSessionStore()
    
    init() {
        sessions = store.load()
    }
    
    func startCharging(stationName: String) {
        activeSession = ChargingSession(
            id: UUID(),
            stationName: stationName,
            startTime: Date(),
            endTime: nil
        )
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let start = self?.activeSession?.startTime else { return }
            self?.liveDuration = Date().timeIntervalSince(start)
        }
    }
    
    func stopCharging() {
        guard var session = activeSession else { return }
        
        timer?.invalidate()
        
        session = ChargingSession(
            id: session.id,
            stationName: session.stationName,
            startTime: session.startTime,
            endTime: Date()
        )
        
        sessions.append(session)
        store.save(sessions)
        activeSession = nil
    }
    
    func averageChargingTime() -> TimeInterval {
        let durations = sessions.compactMap { $0.duration }
        guard !durations.isEmpty else { return 0 }
        return durations.reduce(0, +) / Double(durations.count)
    }
    
    var totalCharges: Int {
        sessions.count
    }

    var chargesThisWeek: Int {
        let calendar = Calendar.current
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        return sessions.filter { $0.startTime >= weekAgo }.count
    }

    var co2Saved: Double {
        Double(totalCharges) * 1.2
    }
    
    var weeklyChartData: [(Date, Int)] {
        let calendar = Calendar.current
        
        return (0..<7).map { i in
            let date = calendar.date(byAdding: .day, value: -i, to: Date())!
            
            let count = sessions.filter {
                calendar.isDate($0.startTime, inSameDayAs: date)
            }.count
            
            return (date, count)
        }.reversed()
    }
    
    var mostUsedStations: [(String, Int)] {
        let grouped = Dictionary(grouping: sessions, by: { $0.stationName })
        
        return grouped.map { (key, value) in
            (key, value.count)
        }
        .sorted { $0.1 > $1.1 }
    }
}
