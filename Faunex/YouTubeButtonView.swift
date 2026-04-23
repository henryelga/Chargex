//
//  YouTubeButtonView.swift
//  Faunex
//
//  Created by Student on 23/04/2026.
//

import SwiftUI

struct YouTubeButtonView: View {
    let videoID: String

    var url: URL {
        URL(string: "https://www.youtube.com/watch?v=\(videoID)")!
    }

    var body: some View {
        Button {
            UIApplication.shared.open(url)
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: 200)
                    .cornerRadius(12)

                Text("▶ Play Video")
                    .font(.headline)
            }
        }
    }
}
