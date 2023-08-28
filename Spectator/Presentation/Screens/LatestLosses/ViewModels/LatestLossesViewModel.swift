//
//  LatestLossesViewModel.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

final class LatestLossesViewModel {
    private(set) var losses: Losses

    var numberOfLossTypes: Int {
        LossType.allCases.count
    }

    init(losses: Losses) {
        self.losses = losses
    }

    func getLossesTypeForIndex(_ index: Int) -> LossType? {
        LossType(rawValue: index)
    }

    func getLossesForIndex(_ index: Int) -> TodayLosses? {
        guard let lossType = LossType(rawValue: index),
              let previousDayPersonnelLosses = losses.personnelLosses?.secondToLast,
              let todayPersonnelLosses = losses.personnelLosses?.last,
              let previousDayEquipmentLosses = losses.equipmentLosses?.secondToLast,
              let todayEquipmentLosses = losses.equipmentLosses?.last
        else { return nil }
        let todayLosses: Int?
        let totalLosses: Int?
        switch lossType {
        case .personnel:
            todayLosses = todayPersonnelLosses.personnel - previousDayPersonnelLosses.personnel
            totalLosses = todayPersonnelLosses.personnel
        case .aircraft:
            todayLosses = (todayEquipmentLosses.aircraft ?? 0) - (previousDayEquipmentLosses.aircraft ?? 0)
            totalLosses = todayEquipmentLosses.aircraft
        case .helicopter:
            todayLosses = (todayEquipmentLosses.helicopter ?? 0) - (previousDayEquipmentLosses.helicopter ?? 0)
            totalLosses = todayEquipmentLosses.helicopter
        case .tank:
            todayLosses = (todayEquipmentLosses.tank ?? 0) - (previousDayEquipmentLosses.tank ?? 0)
            totalLosses = todayEquipmentLosses.tank
        case .armouredPersonnelCarrier:
            todayLosses = (todayEquipmentLosses.armouredPersonnelCarrier ?? 0)
                - (previousDayEquipmentLosses.armouredPersonnelCarrier ?? 0)
            totalLosses = todayEquipmentLosses.armouredPersonnelCarrier
        case .fieldArtillery:
            todayLosses = (todayEquipmentLosses.fieldArtillery ?? 0) - (previousDayEquipmentLosses.fieldArtillery ?? 0)
            totalLosses = todayEquipmentLosses.fieldArtillery
        case .multipleRocketLauncher:
            todayLosses = (todayEquipmentLosses.multipleRocketLauncher ?? 0)
                - (previousDayEquipmentLosses.multipleRocketLauncher ?? 0)
            totalLosses = todayEquipmentLosses.multipleRocketLauncher
        case .drone:
            todayLosses = (todayEquipmentLosses.drone ?? 0)
                - (previousDayEquipmentLosses.drone ?? 0)
            totalLosses = todayEquipmentLosses.drone
        case .navalShip:
            todayLosses = (todayEquipmentLosses.navalShip ?? 0)
                - (previousDayEquipmentLosses.navalShip ?? 0)
            totalLosses = todayEquipmentLosses.navalShip
        case .antiAircraftWarfare:
            todayLosses = (todayEquipmentLosses.antiAircraftWarfare ?? 0)
                - (previousDayEquipmentLosses.antiAircraftWarfare ?? 0)
            totalLosses = todayEquipmentLosses.antiAircraftWarfare
        case .specialEquipment:
            todayLosses = (todayEquipmentLosses.specialEquipment ?? 0)
                - (previousDayEquipmentLosses.specialEquipment ?? 0)
            totalLosses = todayEquipmentLosses.specialEquipment
        case .vehiclesAndFuelTanks:
            todayLosses = (todayEquipmentLosses.vehiclesAndFuelTanks ?? 0)
                - (previousDayEquipmentLosses.vehiclesAndFuelTanks ?? 0)
            totalLosses = todayEquipmentLosses.vehiclesAndFuelTanks
        case .cruiseMissiles:
            todayLosses = (todayEquipmentLosses.cruiseMissiles ?? 0)
                - (previousDayEquipmentLosses.cruiseMissiles ?? 0)
            totalLosses = todayEquipmentLosses.cruiseMissiles
        }
        let todayLossesString = todayLosses?.toString()
        let totalLossesString = totalLosses?.toString()
        return TodayLosses(todayLosses: todayLossesString ?? "0",
                           totalLosses: totalLossesString ?? "0",
                           lossType: lossType)
    }
}
