import Foundation
import Combine

class MapViewModel: ObservableObject {
    
    @Published var stations: [ChargingStation] = []
    
    private let service = OverpassService()
    
    func loadStations() {
        service.fetchChargingStations { [weak self] stations in
            self?.stations = stations
        }
    }
}
