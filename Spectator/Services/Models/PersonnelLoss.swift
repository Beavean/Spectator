//
//  PersonnelLoss.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

struct PersonnelLoss: Codable {
    let date: String
    let day: Int
    let personnel: Int
    let personnelLossPersonnel: String
    let pow: Int?

    enum CodingKeys: String, CodingKey {
        case date
        case day
        case personnel
        case personnelLossPersonnel = "personnel*"
        case pow = "POW"
    }
}
