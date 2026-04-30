import SwiftUI
import SwiftData
import MapKit
import UIKit

struct StationDetailView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var saved: [SavedStation]
    
    @StateObject private var chargingController = ChargingController()
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("notificationDelay") private var notificationDelay = 10
    
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
                chademo: station.chademo
            )
            context.insert(newSaved)
        }
    }
    
    func formatDuration(_ interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    func openInAppleMaps() {
        
        let coordinate = station.coordinate
        
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = station.name ?? "Charging Station"
        
        let options = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ]
        
        mapItem.openInMaps(launchOptions: options)
    }
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 16) {
                
                Text(station.name ?? "EV Charging Station")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                
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
                    
                    InfoRow(icon: "creditcard", title: "Fee", value: (station.fee ?? "Unknown").capitalized)
                    InfoRow(icon: "lock.open", title: "Access", value: (station.access ?? "Unknown").capitalized)
                    InfoRow(icon: "clock", title: "Hours", value: (station.openingHours ?? "Not listed").capitalized)
                    InfoRow(icon: "square.grid.2x2", title: "Capacity", value: (station.capacity ?? "N/A").capitalized)
                    
                    if let type2 = station.type2 {
                        InfoRow(icon: "bolt.car.fill", title: "Type 2", value: type2.capitalized)
                    }
                    
                    if let chademo = station.chademo {
                        InfoRow(icon: "bolt.fill", title: "CHAdeMO", value: chademo.capitalized)
                    }
                    
                    if let phone = station.phone {
                        InfoRow(icon: "phone.fill", title: "Phone", value: phone.capitalized)
                    }
                    
                    if let address = station.address {
                        InfoRow(icon: "map.fill", title: "Address", value: address.capitalized)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                if chargingController.activeSession != nil {
                    Text("Charging for: \(formatDuration(chargingController.liveDuration))")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                
                VStack(spacing: 12) {
                    
                    if chargingController.activeSession == nil {
                        Button {
                            chargingController.startCharging(stationName: station.name ?? "EV Station")

                            if notificationsEnabled {
                                NotificationManager.shared.scheduleChargingNotification(
                                    after: notificationDelay,
                                    stationName: station.name ?? "EV Station"
                                )
                            }
                        } label: {
                            Text("Start Charging")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    } else {
                        Button {
                            chargingController.stopCharging()
                            NotificationManager.shared.cancelChargingNotification()
                        } label: {
                            Text("Stop Charging")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(.top)
                
                Button {
                    openInAppleMaps()
                } label: {
                    Text("Get Directions")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
