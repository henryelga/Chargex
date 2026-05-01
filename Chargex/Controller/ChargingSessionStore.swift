import Foundation

class ChargingSessionStore {
    
    private let key = "charging_sessions"
    
    func save(_ sessions: [ChargingSession]) {
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func load() -> [ChargingSession] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let sessions = try? JSONDecoder().decode([ChargingSession].self, from: data) else {
            return []
        }
        return sessions
    }
}
