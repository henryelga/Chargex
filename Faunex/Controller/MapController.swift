import Foundation
import Combine

class MapController: ObservableObject {
    
    @Published var stations: [ChargingStation] = []
    
    @Published var showFreeOnly: Bool = false
    @Published var requireType2: Bool = false
    @Published var requireCHAdeMO: Bool = false
    @Published var requireFast: Bool = false
    
    @Published var filteredStations: [ChargingStation] = []
    
    private let service = OverpassService()
    
    init() {
        Publishers.CombineLatest4(
            $showFreeOnly,
            $requireType2,
            $requireCHAdeMO,
            $requireFast
        )
        .sink { [weak self] _, _, _, _ in
            self?.applyFilters()
        }
        .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
    
    func loadStations() {
        service.fetchChargingStations { [weak self] stations in
            self?.stations = stations
            self?.applyFilters()
        }
    }
    
    func applyFilters() {
        filteredStations = stations.filter { station in
            
            // FREE FILTER
            if showFreeOnly {
                if station.fee?.lowercased() != "no" {
                    return false
                }
            }
            
            // TYPE 2 FILTER
            if requireType2 {
                guard let type2 = station.type2,
                      let value = Int(type2),
                      value > 0 else {
                    return false
                }
            }
            
            // CHAdeMO FILTER
            if requireCHAdeMO {
                guard let chademo = station.chademo,
                      let value = Int(chademo),
                      value > 0 else {
                    return false
                }
            }
            
            // FAST CHARGER FILTER
            if requireFast {
                let output = station.chademoOutput ?? station.type2Output ?? ""
                if !output.contains("50") {
                    return false
                }
            }
            
            return true
        }
    }
}
