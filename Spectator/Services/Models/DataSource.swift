//
//  DataSource.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

enum DataSource {
    case equipmentLosses
    case personnelLosses
    case equipmentOryxLosses

    var urlString: String {
        let urlString: String
        switch self {
        case .equipmentLosses:
            urlString = Constants.URLs.equipmentLosses
        case .personnelLosses:
            urlString = Constants.URLs.personnelLosses
        case .equipmentOryxLosses:
            urlString = Constants.URLs.equipmentOryxLosses
        }
        return urlString
    }

    var fileName: String {
        switch self {
        case .equipmentLosses:
            return "russia_losses_equipment"
        case .personnelLosses:
            return "russia_losses_personnel"
        case .equipmentOryxLosses:
            return "russia_losses_equipment_oryx"
        }
    }
}
