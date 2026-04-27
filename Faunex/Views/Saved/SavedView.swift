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
        NavigationView {
            List {
                ForEach(saved) { sav in
                    SavedRowView(
                        sav: sav,
                        expandedID: $expandedID,
                        context: context
                    )
                }
            }
            .navigationTitle("Saved Stations")
        }
    }
}
