	//
//  ChargeSession.swift
//  Faunex
//
//  Created by Student on 24/04/2026.
//

import Foundation

struct ChargeSession: Codable, Identifiable {
    var id = UUID()
    var date: Date
    var stationName: String
    var latitude: Double
    var longitude: Double
}
