//
//  LiveScreen.swift
//  Faunex
//
//  Created by Student on 20/04/2026.
//

import SwiftUI
import YouTubePlayerKit

struct LiveScreen: View {

    let seaOttersPlayer = YouTubePlayer(source: .video(id: "9mg9PoFEX2U"))
    let penguinsPlayer = YouTubePlayer(source: .video(id: "NiwrvhQIHIo"))
    let rhinoPlayer = YouTubePlayer(source: .video(id: "YhXWGJQtEQY"))
    let plainsPlayer = YouTubePlayer(source: .video(id: "1HxOxiMZUNI"))

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Text("Live Endangered Animal Cam")
                    .font(.title)
                    .bold()

                VStack(alignment: .leading) {
                    Text("Sea Otters").font(.headline)
                    YouTubePlayerView(seaOttersPlayer)
                        .frame(height: 200)
                }

                VStack(alignment: .leading) {
                    Text("African Penguins").font(.headline)
                    YouTubePlayerView(penguinsPlayer)
                        .frame(height: 200)
                }

                VStack(alignment: .leading) {
                    Text("Rhino Orphans").font(.headline)
                    YouTubePlayerView(rhinoPlayer)
                        .frame(height: 200)
                }

                VStack(alignment: .leading) {
                    Text("Great Plains").font(.headline)
                    YouTubePlayerView(plainsPlayer)
                        .frame(height: 200)
                }
            }
            .padding()
        }
    }
}
