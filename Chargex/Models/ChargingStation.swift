import Foundation
import CoreLocation

struct ChargingStation: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
    let name: String?
    let operatorName: String?
    let ref: String?
    
    let fee: String?
    let access: String?
    let openingHours: String?
    
    let capacity: String?
    let phone: String?
    
    let type2: String?
    let type2Combo: String?
    let chademo: String?
    let type2Output: String?
    let chademoOutput: String?
    
    var voltage: String?
    var amperage: String?
    
    let address: String?
    
    static func ==(lhs: ChargingStation, rhs: ChargingStation) -> Bool {
        return lhs.id == rhs.id
    }
}
