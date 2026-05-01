//
//  Color+Theme.swift
//  Faunex
//
//  Created by Student on 30/04/2026.
//
import SwiftUI

extension Color {
    
    static let chargexPrimary = Color(hex: "#A9FF6B")
    
    static let chargexBackground = Color(
        light: Color(hex: "#F0FFE3"),
        dark: Color(hex: "#2a2e27")
    )
    
    static let chargexCard = Color(
        light: .white,
        dark: Color(hex: "#1E1E1E")
    )
    
    static let chargexTextPrimary = Color(
        light: Color(hex: "#252524"),
        dark: .white
    )
    
    static let chargexYellow = Color(hex: "#fff870")
    static let chargexBlue = Color(hex: "#8cbeff")
}

extension Color {
    init(light: Color, dark: Color) {
        self = Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(dark)
            : UIColor(light)
        })
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b: UInt64
        
        switch hex.count {
        case 6:
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}
