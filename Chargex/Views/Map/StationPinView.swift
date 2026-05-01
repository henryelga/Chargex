import SwiftUI

struct StationPinView: View {
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color.chargexPrimary.opacity(0.2))
                .frame(width: 46, height: 46)
            
            Circle()
                .fill(Color.chargexPrimary)
                .frame(width: 28, height: 28)
            
            Image(systemName: "bolt.fill")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color.chargexTextPrimary)
        }
        .shadow(color: Color.chargexPrimary.opacity(0.35),
                radius: 8, x: 0, y: 4)
    }
}
