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
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                Text("Home")
            }
            
            Tab("Map", systemImage: "map") {
                Text("Map")
            }
            
            Tab("Live", systemImage: "video") {
                QuizScreen()
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .dynamicTypeSize(isLargeText ? .xLarge : .medium)
    }
}

#Preview {
    ContentView()
}
