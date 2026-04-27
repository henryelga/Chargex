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
    
    var operatorName: String?
    var fee: String?
    var access: String?
    var openingHours: String?
    var capacity: String?
    var phone: String?
    var type2: String?
    var chademo: String?
    
    init(
        id: String,
        name: String?,
        address: String?,
        operatorName: String? = nil,
        fee: String? = nil,
        access: String? = nil,
        openingHours: String? = nil,
        capacity: String? = nil,
        phone: String? = nil,
        type2: String? = nil,
        chademo: String? = nil
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.operatorName = operatorName
        self.fee = fee
        self.access = access
        self.openingHours = openingHours
        self.capacity = capacity
        self.phone = phone
        self.type2 = type2
        self.chademo = chademo
    }
}
