import SwiftUI
import MapKit

struct FilterSheet: View {
    @ObservedObject var controller: MapController
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Price") {
                    Toggle("Free Only", isOn: $controller.showFreeOnly)
                }
                
                Section("Sockets") {
                    Toggle("Type 2", isOn: $controller.requireType2)
                    Toggle("CHAdeMO", isOn: $controller.requireCHAdeMO)
                }
                
                Section("Charger Speed") {
                    Toggle("Fast Charger (≥50kW)", isOn: $controller.requireFast)
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
