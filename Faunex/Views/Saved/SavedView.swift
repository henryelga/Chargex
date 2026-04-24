import SwiftUI
import SwiftData

struct SavedView: View {
    
    @Query private var saved: [SavedStation]
    @Environment(\.modelContext) private var context
    
    var body: some View {
            NavigationView {
                List {
                    ForEach(saved) { fav in
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(fav.name ?? "Unknown Station")
                                    .font(.headline)
                                
                                Text(fav.address ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button {
                                context.delete(fav)
                            } label: {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .navigationTitle("Saved Stations")
            }
        }
}
