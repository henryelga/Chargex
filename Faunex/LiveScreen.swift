//
//  LiveScreen.swift
//  Faunex
//
//  Created by Student on 20/04/2026.
//
import SwiftUI

struct LiveScreen: View {

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {

                Text("Live Endangered Animal Cam")
                    .font(.title)
                    .bold()
                
                YouTubeButtonView(videoID: "9mg9PoFEX2U")

                VideoBlock(title: "Sea Otters", id: "9mg9PoFEX2U")
                VideoBlock(title: "African Penguins", id: "NiwrvhQIHIo")
                VideoBlock(title: "Rhino Orphans", id: "YhXWGJQtEQY")
                VideoBlock(title: "Great Plains", id: "1HxOxiMZUNI")
            }
            .padding()
        }
    }
}

struct VideoBlock: View {
    let title: String
    let id: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            YouTubeWebView(videoID: id)
                .frame(height: 200)
                .cornerRadius(12)
        }
    }
}
