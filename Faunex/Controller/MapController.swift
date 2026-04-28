import Foundation
import Combine

enum SocketType {
    case none
    case type2
    case chademo
    case type2Combo
}

class MapController: ObservableObject {
    
    @Published var stations: [ChargingStation] = []
    @Published var filteredStations: [ChargingStation] = []
    
    // Filters
    @Published var showFreeOnly: Bool = false
    @Published var requireFast: Bool = false
    @Published var selectedSocketType: SocketType = .none
    @Published var selectedOperator: String = "Any"
    
    private let service = OverpassService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Publishers.CombineLatest4(
            $showFreeOnly,
            $selectedSocketType,
            $selectedOperator,
            $requireFast
        )
        .sink { [weak self] _, _, _, _ in
            self?.applyFilters()
        }
        .store(in: &cancellables)
    }
    
    func loadStations() {
        service.fetchChargingStations { [weak self] stations in
            self?.stations = stations
            self?.applyFilters()
        }
    }
    
    func applyFilters() {
        filteredStations = stations.filter { station in
            
            // FREE FILTER
            if showFreeOnly && station.fee?.lowercased() != "no" {
                return false
            }
            
            // SOCKET TYPE FILTER
            if selectedSocketType != .none {
                switch selectedSocketType {
                case .type2:
                    guard let type2 = station.type2, Int(type2) ?? 0 > 0 else { return false }
                case .chademo:
                    guard let chademo = station.chademo, Int(chademo) ?? 0 > 0 else { return false }
                case .type2Combo:
                    guard let type2Combo = station.type2Combo, Int(type2Combo) ?? 0 > 0 else { return false }
                case .none:
                    break
                }
            }
            
            // OPERATOR FILTER
            if selectedOperator != "Any", station.operatorName?.lowercased() != selectedOperator.lowercased() {
                return false
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
    
    func getUniqueOperators() -> [String] {
        let operators = Set(stations.compactMap { $0.operatorName })
        return ["Any"] + operators.sorted()
    }
}
