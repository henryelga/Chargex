//
//  SavedStation.swift
//  Faunex
//
//  Created by Student on 24/04/2026.
//

import Foundation
import SwiftData

@Model
class SavedStation {
    var id: String
    var name: String?
    var address: String?
    
    init(id: String, name: String?, address: String?) {
        self.id = id
        self.name = name
        self.address = address
    }
}
