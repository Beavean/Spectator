//
//  OryxLoss.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

struct OryxLoss: Codable {
    let equipmentOryx, model: String
    let manufacturer: Manufacturer
    let lossesTotal: Int
    let equipmentType: EquipmentType

    enum CodingKeys: String, CodingKey {
        case equipmentOryx = "equipment_oryx"
        case model, manufacturer
        case lossesTotal = "losses_total"
        case equipmentType = "equipment_ua"
    }
}

enum Manufacturer: String, Codable {
    case iran = "Iran"
    case israel = "Israel"
    case italy = "Italy"
    case poland = "Poland"
    case russia = "Russia"
    case theCzechRepublic = "the Czech Republic"
    case theSovietUnion = "the Soviet Union"
}
