//
//  ChargexApp.swift
//  Chargex
//
//  Created by Student on 20/03/2026.
//

import SwiftUI
import SwiftData

@main
struct ChargexApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: SavedStation.self)
    }
}
