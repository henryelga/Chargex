//
//  SavedRowView.swift
//  Faunex
//
//  Created by Student on 24/04/2026.
//

import SwiftUI
import SwiftData

struct SavedRowView: View {
    
    let sav: SavedStation
    @Binding var expandedID: String?
    let context: ModelContext
    
    var isExpanded: Bool {
        expandedID == sav.id
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // MARK: - Header tap
            Button {
                withAnimation(.easeInOut) {
                    expandedID = isExpanded ? nil : sav.id
                }
            } label: {
                HStack {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(sav.name ?? "Unknown Station")
                            .font(.headline)
                            .foregroundColor(.chargexTextPrimary)
                        
                        Text(sav.address ?? "No address")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
            
            // MARK: - Expanded content
            if isExpanded {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Divider().opacity(0.3)
                    
                    Text("Details")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 6) {
                        DetailRow(title: "Operator", value: sav.operatorName)
                        DetailRow(title: "Fee", value: sav.fee)
                        DetailRow(title: "Access", value: sav.access)
                        DetailRow(title: "Hours", value: sav.openingHours)
                        DetailRow(title: "Capacity", value: sav.capacity)
                        DetailRow(title: "Phone", value: sav.phone)
                        DetailRow(title: "Type 2", value: sav.type2)
                        DetailRow(title: "CHAdeMO", value: sav.chademo)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(role: .destructive) {
                            context.delete(sav)
                        } label: {
                            Text("Remove")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.top, 4)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(16)
        .background(
            LinearGradient(
                colors: [
                    Color.chargexCard,
                    Color.chargexCard.opacity(0.92)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 5)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                context.delete(sav)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

struct DetailRow: View {
    
    let title: String
    let value: String?
    
    var body: some View {
        if let value {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(value.capitalized)
                    .font(.caption)
                    .foregroundColor(.chargexTextPrimary)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.vertical, 2)
        }
    }
}
