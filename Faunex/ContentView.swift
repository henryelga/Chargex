//
//  ContentView.swift
//  Faunex
//
//  Created by Student on 20/03/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                Text("Home")
            }
            
            Tab("Map", systemImage: "map") {
                MapScreen()
            }
            
            Tab("Live", systemImage: "video") {
                Text("Live")
            }
            
            Tab("Settings", systemImage: "gear") {
                Text("Settings")
            }
        }
    }
}

#Preview {
    ContentView()
}
