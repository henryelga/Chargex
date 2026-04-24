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
                
                if let elementLat = element["lat"] as? Double,
                   let elementLon = element["lon"] as? Double {
                    lat = elementLat
                    lon = elementLon
                }
                
                if lat == nil,
                   let center = element["center"] as? [String: Double] {
                    lat = center["lat"]
                    lon = center["lon"]
                }
                
                guard let lat = lat, let lon = lon else {
                    return nil
                }
                
                let tags = element["tags"] as? [String: Any]

                let name = tags?["name"] as? String
                let operatorName = tags?["operator"] as? String
                let ref = tags?["ref"] as? String

                let fee = tags?["fee"] as? String
                let access = tags?["access"] as? String
                let openingHours = tags?["opening_hours"] as? String

                let capacity = tags?["capacity"] as? String
                let phone = tags?["phone"] as? String

                let type2 = tags?["socket:type2"] as? String
                let chademo = tags?["socket:chademo"] as? String
                let type2Output = tags?["socket:type2:output"] as? String
                let chademoOutput = tags?["socket:chademo:output"] as? String

                let city = tags?["addr:city"] as? String
                let street = tags?["addr:street"] as? String

                let parts = [street, city].compactMap { $0 }
                let joinedAddress = parts.joined(separator: ", ")
                let address = joinedAddress.isEmpty ? nil : joinedAddress

                return ChargingStation(
                    coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                    name: name,
                    operatorName: operatorName,
                    ref: ref,
                    fee: fee,
                    access: access,
                    openingHours: openingHours,
                    capacity: capacity,
                    phone: phone,
                    type2: type2,
                    chademo: chademo,
                    type2Output: type2Output,
                    chademoOutput: chademoOutput,
                    address: address
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
