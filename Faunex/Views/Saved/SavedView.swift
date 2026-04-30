//
//  SavedView.swift
//  Faunex
//
//  Created by Student on 24/04/2026.
//

import SwiftUI
import SwiftData

struct SavedView: View {
    
    @Query private var saved: [SavedStation]
    @Environment(\.modelContext) private var context
    @State private var expandedID: String?
    
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
                
                List {
                    
                    // MARK: - Header Section
                    Section {
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Saved Stations")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.chargexTextPrimary)
                            
                            Text("Your favourite charging locations for quick access.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    }
                    
                    // MARK: - Saved Stations
                    Section {
                        if saved.isEmpty {
                            
                            VStack(spacing: 10) {
                                Image(systemName: "bookmark.slash")
                                    .font(.system(size: 40))
                                    .foregroundColor(.secondary)
                                
                                Text("No saved stations yet")
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            
                        } else {
                            
                            ForEach(saved) { sav in
                                SavedRowView(
                                    sav: sav,
                                    expandedID: $expandedID,
                                    context: context
                                )
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Saved")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
