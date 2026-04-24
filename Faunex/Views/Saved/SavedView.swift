import SwiftUI
import SwiftData

struct SavedView: View {
    
    @Query private var saved: [SavedStation]
    @Environment(\.modelContext) private var context
    
    @State private var expandedID: String?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(saved) { sav in
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Button {
                            withAnimation {
                                if expandedID == sav.id {
                                    expandedID = nil
                                } else {
                                    expandedID = sav.id
                                }
                            }
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(sav.name ?? "Unknown Station")
                                        .font(.headline)
                                    
                                    Text(sav.address ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: expandedID == sav.id
                                      ? "chevron.up"
                                      : "chevron.down")
                                    .foregroundColor(.gray)
                            }
                        }
                        .buttonStyle(.plain)
                        
                        if expandedID == sav.id {
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Divider()
                                
                                DetailRow(title: "Operator", value: sav.operatorName)
                                DetailRow(title: "Fee", value: sav.fee)
                                DetailRow(title: "Access", value: sav.access)
                                DetailRow(title: "Hours", value: sav.openingHours)
                                DetailRow(title: "Capacity", value: sav.capacity)
                                DetailRow(title: "Phone", value: sav.phone)
                                DetailRow(title: "Type 2", value: sav.type2)
                                DetailRow(title: "CHAdeMO", value: sav.chademo)
                                DetailRow(title: "Address", value: sav.address)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            context.delete(sav)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Saved Stations")
        }
    }
}

struct DetailRow: View {
    
    let title: String
    let value: String?
    
    var body: some View {
        if let value = value {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(value)
                    .multilineTextAlignment(.trailing)
            }
            .font(.subheadline)
        }
    }
}
