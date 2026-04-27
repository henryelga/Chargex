import SwiftUI
import SwiftData

struct StationDetailView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var saved: [SavedStation]
    
    let station: ChargingStation
    
    private func isSaved(_ station: ChargingStation) -> Bool {
        saved.contains { $0.id == station.ref }
    }
    
    private func toggleSaved() {
        guard let id = station.ref else { return }
        
        if let existing = saved.first(where: { $0.id == id }) {
            context.delete(existing)
        } else {
            let newSaved = SavedStation(
                id: id,
                name: station.name,
                address: station.address,
                operatorName: station.operatorName,
                fee: station.fee,
                access: station.access,
                openingHours: station.openingHours,
                capacity: station.capacity,
                phone: station.phone,
                type2: station.type2,
                chademo: station.chademo            )
            context.insert(newSaved)
        }
    }
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 16) {
                
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                
                Text(station.name ?? "EV Charging Station")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                if let operatorName = station.operatorName {
                    Label(operatorName, systemImage: "building.2.fill")
                        .foregroundColor(.secondary)
                }
                
                Button {
                    toggleSaved()
                } label: {
                    Label(
                        isSaved(station) ? "Saved" : "Save",
                        systemImage: isSaved(station) ? "bookmark.fill" : "bookmark"
                    )
                }
                .buttonStyle(.borderedProminent)
                
                Divider()
                
                VStack(spacing: 12) {
                    
                    InfoRow(icon: "creditcard", title: "Fee", value: station.fee ?? "Unknown")
                    InfoRow(icon: "lock.open", title: "Access", value: station.access ?? "Unknown")
                    InfoRow(icon: "clock", title: "Hours", value: station.openingHours ?? "Not listed")
                    InfoRow(icon: "square.grid.2x2", title: "Capacity", value: station.capacity ?? "N/A")
                    
                    if let type2 = station.type2 {
                        InfoRow(icon: "bolt.car.fill", title: "Type 2", value: type2)
                    }
                    
                    if let chademo = station.chademo {
                        InfoRow(icon: "bolt.fill", title: "CHAdeMO", value: chademo)
                    }
                    
                    if let phone = station.phone {
                        InfoRow(icon: "phone.fill", title: "Phone", value: phone)
                    }
                    
                    if let address = station.address {
                        InfoRow(icon: "map.fill", title: "Address", value: address)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                Spacer()
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
