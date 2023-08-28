//
//  LossType.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

enum LossType: Int, CaseIterable {
    case personnel
    case aircraft
    case helicopter
    case tank
    case armouredPersonnelCarrier
    case fieldArtillery
    case multipleRocketLauncher
    case drone
    case navalShip
    case antiAircraftWarfare
    case specialEquipment
    case vehiclesAndFuelTanks
    case cruiseMissiles

    var title: String {
        switch self {
        case .personnel:
            return LocalizedString.personnelLoss.localized
        case .aircraft:
            return LocalizedString.aircraftLoss.localized
        case .helicopter:
            return LocalizedString.helicopterLoss.localized
        case .tank:
            return LocalizedString.tankLoss.localized
        case .armouredPersonnelCarrier:
            return LocalizedString.armouredPersonnelCarrierLoss.localized
        case .fieldArtillery:
            return LocalizedString.fieldArtilleryLoss.localized
        case .multipleRocketLauncher:
            return LocalizedString.multipleRocketLauncherLoss.localized
        case .drone:
            return LocalizedString.droneLoss.localized
        case .navalShip:
            return LocalizedString.navalShipLoss.localized
        case .antiAircraftWarfare:
            return LocalizedString.antiAircraftWarfareLoss.localized
        case .specialEquipment:
            return LocalizedString.specialEquipmentLoss.localized
        case .vehiclesAndFuelTanks:
            return LocalizedString.vehiclesAndFuelTanksLoss.localized
        case .cruiseMissiles:
            return LocalizedString.cruiseMissilesLoss.localized
        }
    }
}
