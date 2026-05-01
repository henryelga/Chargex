//
//  InfoView.swift
//  Faunex
//
//  Created by Student on 28/04/2026.
//

import SwiftUI

struct InfoView: View {
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                // MARK: - Background
                LinearGradient(
                    colors: [
                        Color.chargexBackground,
                        Color.chargexBackground.opacity(0.6)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        // MARK: - Header
                        VStack(alignment: .leading, spacing: 6) {
                            Text("How to Use Chargex")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.chargexTextPrimary)
                            
                            Text("Everything you need to get the most out of your charging experience.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        
                        
                        // MARK: - Cards
                        InfoCard(
                            title: "Dashboard",
                            icon: "chart.bar.fill",
                            color: .blue,
                            content: """
                            • CO₂ Saved shows your environmental impact.
                            • Total Charges tracks all sessions.
                            • Weekly activity shows recent usage.
                            • Charts visualise your charging habits.
                            • Stations show where you charge most.
                            """
                        )

                        InfoCard(
                            title: "Charging (Map)",
                            icon: "map.fill",
                            color: .green,
                            content: """
                            • Tap a station to view details.
                            • Start charging to begin tracking.
                            • Timer runs automatically.
                            • Get notified when complete.
                            • Stop charging when finished.
                            """
                        )

                        InfoCard(
                            title: "Saved Stations",
                            icon: "bookmark.fill",
                            color: .orange,
                            content: """
                            • Save favourite charging locations.
                            • Tap to view full details.
                            • Expand for more information.
                            • Swipe to remove saved stations.
                            """
                        )

                        InfoCard(
                            title: "Notifications",
                            icon: "bell.fill",
                            color: .purple,
                            content: """
                            • Set charging reminders.
                            • Choose session duration.
                            • Get alerts when time is up.
                            • Prevent overcharging.
                            """
                        )
                        
                        Spacer(minLength: 30)
                    }
                    .padding()
                }
            }
            .navigationTitle("Info")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct InfoCard: View {
    
    let title: String
    let icon: String
    let color: Color
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            HStack(spacing: 12) {
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(color)
                    .frame(width: 38, height: 38)
                    .background(color.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.chargexTextPrimary)
                
                Spacer()
            }
            
            Text(content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineSpacing(5)
        }
        .padding(16)
        .background(Color.chargexCard)
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}
