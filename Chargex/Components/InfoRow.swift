import SwiftUI

struct InfoRow: View {
    
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            
            Label(title, systemImage: icon)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(value)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
        .padding(.vertical, 6)
    }
}
