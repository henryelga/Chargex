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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Button {
                withAnimation {
                    expandedID = (expandedID == sav.id) ? nil : sav.id
                }
            } label: {
                header
            }
            .buttonStyle(.plain)
            
            if expandedID == sav.id {
                details
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                context.delete(sav)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(sav.name ?? "Unknown Station")
                    .font(.headline)
                
                Text(sav.address ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: expandedID == sav.id ? "chevron.up" : "chevron.down")
                .foregroundColor(.gray)
        }
    }
    
    private var details: some View {
        VStack(alignment: .leading, spacing: 6) {
            Divider()
            
            DetailRow(title: "Operator", value: sav.operatorName)
            DetailRow(title: "Fee", value: sav.fee)
            DetailRow(title: "Access", value: sav.access)
            DetailRow(title: "Hours", value: sav.openingHours)
            DetailRow(title: "Capacity", value: sav.capacity)
            DetailRow(title: "Phone", value: sav.phone)
            DetailRow(title: "Type 2", value: sav.type2)
            DetailRow(title: "CHAdeMO", value: sav.chademo)
            DetailRow(title: "Address", value: sav.address)
        }
        .padding(.top, 4)
    }
}

struct DetailRow: View {
    
    let title: String
    let value: String?
    
    var body: some View {
        if let value = value {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(value)
                    .multilineTextAlignment(.trailing)
            }
            .font(.subheadline)
        }
    }
}
