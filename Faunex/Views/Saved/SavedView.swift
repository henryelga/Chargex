import SwiftUI
import SwiftData

struct SavedView: View {
    
    @Query private var saved: [SavedStation]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
            List {
                ForEach(saved) { sav in
                    
                    VStack(alignment: .leading) {
                        Text(sav.name ?? "Unknown Station")
                            .font(.headline)
                        
                        Text(sav.address ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
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
