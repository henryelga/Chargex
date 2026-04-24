import Foundation
import CoreLocation

struct ChargingStation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let name: String?
}
