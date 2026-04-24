//
//  DashboardView.swift
//  Faunex
//
//  Created by Student on 24/04/2026.
//

import SwiftUI
import Charts

struct DashboardView: View {
    
    @EnvironmentObject var sessionController: SessionController
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nice work choosing electric ⚡️")
                        .font(.title2)
                        .bold()
                    
                    Text("CO₂ saved (estimate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(String(format: "%.1f kg", sessionController.co2Saved))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.1))
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        StatCard(title: "Total Charges", value: "\(sessionController.totalCharges)")
                        StatCard(title: "This Week", value: "\(sessionController.chargesThisWeek)")
                    }
                    
                    Text("Weekly Activity")
                        .font(.headline)
                    
                    if #available(iOS 16.0, *) {
                        Chart {
                            ForEach(sessionController.weeklyChartData, id: \.0) { item in
                                BarMark(
                                    x: .value("Day", item.0, unit: .day),
                                    y: .value("Charges", item.1)
                                )
                            }
                        }
                        .frame(height: 200)
                    } else {
                        Text("Chart requires iOS 16+")
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Most Used Stations")
                        .font(.headline)
                    
                    if sessionController.mostUsedStations.isEmpty {
                        Text("No charging sessions yet")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(sessionController.mostUsedStations, id: \.0) { station, count in
                            HStack {
                                Text(station)
                                Spacer()
                                Text("\(count) times")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Spacer(minLength: 20)
            }
            .padding()
        }
    }
}

struct StatCard: View {
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title3)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
