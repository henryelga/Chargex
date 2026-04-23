//
//  YouTubeWebView.swift
//  Faunex
//
//  Created by Student on 23/04/2026.
//

import SwiftUI
import WebKit

struct YouTubeWebView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true

        return WKWebView(frame: .zero, configuration: config)
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
        </head>
        <body style="margin:0;padding:0;background-color:black;">
            <iframe
                width="100%"
                height="100%"
                src="https://www.youtube.com/embed/\(videoID)?playsinline=1"
                frameborder="0"
                allow="autoplay; encrypted-media"
                allowfullscreen>
            </iframe>
        </body>
        </html>
        """


        let youtubeURL = URL(string: "https://www.youtube.com")
        webView.loadHTMLString(html, baseURL: youtubeURL)
    }
}
