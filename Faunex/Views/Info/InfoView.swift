//
//  InfoView.swift
//  Faunex
//
//  Created by Student on 28/04/2026.
//

import SwiftUI

struct InfoView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to Use Chargex ⚡️")
                            .font(.title2)
                            .bold()
                        
                        Text("Quick guide to help you get the most out of the app.")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    InfoCard(
                        title: "Dashboard",
                        icon: "chart.bar.fill",
                        color: .green,
                        content: """
                        • CO₂ Saved shows an estimate of emissions you’ve avoided by charging electric.

                        • Total Charges is how many charging sessions you've completed.

                        • This Week shows how active you’ve been recently.

                        • The chart displays your charging activity across the week.

                        • Most Used Stations shows where you charge most often.
                        """
                    )
                    
                    InfoCard(
                        title: "Charging (Map)",
                        icon: "map.fill",
                        color: .blue,
                        content: """
                        • Tap a station on the map to view details.

                        • Pull up the card to see the Start Charging button.
                        
                        • Press Start Charging when you begin charging your car.
                        
                        • A timer will start and track how long you've been charging.
                        
                        • If notifications are enabled, you’ll get an alert when your selected time is up.

                        • Press Stop Charging when you’re done.
                        """
                    )
                    
                    InfoCard(
                        title: "Saved Stations",
                        icon: "bookmark.fill",
                        color: .orange,
                        content: """
                        • Save stations to quickly access them later.

                        • Tap a saved station to view full details.

                        • Use the toggle to expand and see more information.

                        • Swipe left on a station to delete it from your saved list.
                        """
                    )
                    
                    InfoCard(
                        title: "Notifications",
                        icon: "bell.fill",
                        color: .purple,
                        content: """
                        • Enable notifications in Settings.

                        • Choose how many minutes you want to charge.

                        • You’ll receive one reminder when that time is reached.

                        • This helps prevent overcharging or forgetting your car.
                        """
                    )
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            .navigationTitle("Info")
        }
    }
}

struct InfoCard: View {
    
    let title: String
    let icon: String
    let color: Color
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.headline)
                
                Spacer()
            }
            
            Text(content)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    InfoView()
}
