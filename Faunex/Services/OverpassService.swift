import Foundation
import CoreLocation

class OverpassService {
    
    func fetchChargingStations(completion: @escaping ([ChargingStation]) -> Void) {
        
        guard let url = Bundle.main.url(forResource: "chargers_ireland", withExtension: "json") else {
            completion([])
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let elements = decoded?["elements"] as? [[String: Any]] ?? []
            
            let stations: [ChargingStation] = elements.compactMap { element in
                
                var lat: Double?
                var lon: Double?
                
                if let l = element["lat"] as? Double,
                   let lo = element["lon"] as? Double {
                    lat = l
                    lon = lo
                }
                
                if lat == nil,
                   let center = element["center"] as? [String: Double] {
                    lat = center["lat"]
                    lon = center["lon"]
                }
                
                guard let lat = lat, let lon = lon else { return nil }
                
                let tags = element["tags"] as? [String: Any]
                let name = tags?["name"] as? String
                
                return ChargingStation(
                    coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                    name: name
                )
            }
            
            DispatchQueue.main.async {
                completion(stations)
            }
            
        } catch {
            print("JSON error:", error)
            completion([])
        }
    }
}
