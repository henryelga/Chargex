import SwiftUI

struct FilterSheet: View {
    @ObservedObject var controller: MapController
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                // Price Filter
                Section("Price") {
                    Toggle("Free Only", isOn: $controller.showFreeOnly)
                }
                
                // Socket Type Filter
                Section("Sockets") {
                    Picker("Socket Type", selection: $controller.selectedSocketType) {
                        Text("None").tag(SocketType.none)
                        Text("Type 2").tag(SocketType.type2)
                        Text("CHAdeMO").tag(SocketType.chademo)
                        Text("Type 2 Combo").tag(SocketType.type2Combo)
                    }
                    .pickerStyle(.menu)
                }
                
                // Charger Speed Filter
                Section("Charger Speed") {
                    Toggle("Fast Charger (≥50kW)", isOn: $controller.requireFast)
                }
                
                // Operator Filter 
                Section("Operator") {
                    Picker("Operator", selection: $controller.selectedOperator) {
                        ForEach(controller.getUniqueOperators(), id: \.self) { operatorName in
                            Text(operatorName).tag(operatorName)
                        }
                    }
                    .pickerStyle(.menu)
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
