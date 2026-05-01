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
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // MARK: - Header
                VStack(spacing: 4) {
                    Text(station.name ?? "EV Charging Station")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(Color.chargexTextPrimary)
                        .multilineTextAlignment(.center)
                    
                    if let operatorName = station.operatorName {
                        Label(operatorName, systemImage: "building.2.fill")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
                .padding(.top, 12)
                
                // MARK: - Save Button
                Button {
                    toggleSaved()
                } label: {
                    Label(
                        isSaved(station) ? "Saved" : "Save",
                        systemImage: isSaved(station) ? "bookmark.fill" : "bookmark"
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.chargexPrimary)
                    .foregroundColor(.black) // <- always dark text
                    .clipShape(Capsule())
                }
                
                // MARK: - Info Card
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
                .background(Color.chargexCard)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                
                // MARK: - Charging Session
                if chargingController.activeSession != nil {
                    Text("Charging for: \(formatDuration(chargingController.liveDuration))")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.top, 4)
                }
                
                // MARK: - Start / Stop Charging
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
                                .background(Color.chargexPrimary)
                                .foregroundColor(.black) // <- always dark text
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
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
                                .foregroundColor(.black) // <- dark text even on red
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    }
                }
                
                // MARK: - Directions Button
                Button {
                    openInAppleMaps()
                } label: {
                    Text("Get Directions")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.chargexBlue)
                        .foregroundColor(.black) // <- always dark text
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                
                Spacer(minLength: 20)
            }
            .padding()
        }
        .background(Color.chargexBackground.ignoresSafeArea())
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
