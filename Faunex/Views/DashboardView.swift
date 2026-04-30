//
//  DashboardView.swift
//  Faunex
//
//  Created by Student on 24/04/2026.
//

import SwiftUI
import Charts

struct DashboardView: View {
    
    @EnvironmentObject var sessionController: ChargingController
    
    var body: some View {
        ZStack {
            // Background
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
                VStack(spacing: 24) {
                    HStack(spacing: 12) {
                        
                        Image("Image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text("Welcome back!")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.chargexTextPrimary)
                        
                        Spacer()
                    }
                    
                    // MARK: - CO2 Card
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Nice work choosing electric ⚡️")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("CO₂ Saved")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(String(format: "%.1f kg", sessionController.co2Saved))
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.chargexTextPrimary)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.chargexPrimary.opacity(0.4),
                                Color.chargexPrimary.opacity(0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    
                    // MARK: - Stats
                    HStack(spacing: 16) {
                        StatCard(
                            title: "Total Charges",
                            value: "\(sessionController.totalCharges)"
                        )
                        
                        StatCard(
                            title: "This Week",
                            value: "\(sessionController.chargesThisWeek)"
                        )
                    }
                    
                    
                    // MARK: - Chart Section
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Weekly Activity")
                            .font(.headline)
                        
                        if #available(iOS 16.0, *) {
                            Chart {
                                ForEach(sessionController.weeklyChartData, id: \.0) { item in
                                    BarMark(
                                        x: .value("Day", item.0, unit: .day),
                                        y: .value("Charges", item.1)
                                    )
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [
                                                Color.chargexYellow,
                                                Color.chargexYellow.opacity(0.6)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .cornerRadius(4)
                                }
                            }
                            .frame(height: 200)
                        } else {
                            Text("Chart requires iOS 16+")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.chargexCard)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                    
                    
                    // MARK: - Stations
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Most Used Stations")
                            .font(.headline)
                        
                        if sessionController.mostUsedStations.isEmpty {
                            Text("No charging sessions yet")
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(sessionController.mostUsedStations, id: \.0) { station, count in
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(station)
                                            .font(.subheadline)
                                            .foregroundColor(.chargexTextPrimary)
                                        
                                        Text("\(count) sessions")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(.chargexPrimary)
                                }
                                .padding()
                                .background(Color.chargexCard)
                                .cornerRadius(14)
                                .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
        }
    }
}

struct StatCard: View {
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.chargexTextPrimary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.chargexCard)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}
