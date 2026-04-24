import SwiftUI
import SwiftData

struct SavedView: View {
    
    @Query private var saved: [SavedStation]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(saved) { fav in
                    VStack(alignment: .leading) {
                        Text(fav.name ?? "Unknown Station")
                            .font(.headline)
                        
                        Text(fav.address ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Saved Stations")
        }
    }
}
