//
//  ContentView.swift
//  Faunex
//
//  Created by Student on 20/03/2026.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isLargeText") private var isLargeText = false
    @StateObject private var sessionStore = ChargingController()

    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house.fill") {
                DashboardView()
                    .environmentObject(sessionStore)
            }
            
            Tab("Map", systemImage: "map.fill") {
                MapScreen()
                    .environmentObject(sessionStore)
            }
            
            Tab("Saved", systemImage: "bookmark.fill") {
                SavedView()
            }
            
            Tab("Info", systemImage: "book.fill") {
                InfoView()
            }
            
            Tab("Settings", systemImage: "gearshape.fill") {
                SettingsScreen()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .dynamicTypeSize(isLargeText ? .xLarge : .medium)
        .toolbarBackground(
            Material.ultraThinMaterial,
            for: .tabBar
        )
        .toolbarBackground(.visible, for: .tabBar)
        .tabViewStyle(.automatic)
        
    }
}

#Preview {
    ContentView()
}
