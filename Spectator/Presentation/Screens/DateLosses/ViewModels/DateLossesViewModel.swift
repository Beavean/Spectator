//
//  DateLossesViewModel.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

final class DateLossesViewModel {
    private let losses: Losses
    private(set) var lossType: LossType
    private var increasingLossDays: [Int] = []
    var numberOfElements: Int {
        return increasingLossDays.count
    }

    init(losses: Losses, lossType: LossType) {
        self.losses = losses
        self.lossType = lossType
        calculateIncreasingLossDays()
    }

    func getReversedIndex(int: Int) -> Int {
        numberOfElements - 1 - int
    }

    func getLosses(forIndex index: Int) -> DateLosses? {
        guard index < numberOfElements else { return nil }
        let actualIndex = increasingLossDays[index]
        var relevantLosses: [Int?] = []
        switch lossType {
        case .personnel:
            relevantLosses = losses.personnelLosses?.map { $0.personnel } ?? []
        case .aircraft:
            relevantLosses = losses.equipmentLosses?.map { $0.aircraft } ?? []
        case .helicopter:
            relevantLosses = losses.equipmentLosses?.map { $0.helicopter } ?? []
        case .tank:
            relevantLosses = losses.equipmentLosses?.map { $0.tank } ?? []
        case .armouredPersonnelCarrier:
            relevantLosses = losses.equipmentLosses?.map { $0.armouredPersonnelCarrier } ?? []
        case .fieldArtillery:
            relevantLosses = losses.equipmentLosses?.map { $0.fieldArtillery } ?? []
        case .multipleRocketLauncher:
            relevantLosses = losses.equipmentLosses?.map { $0.multipleRocketLauncher } ?? []
        case .drone:
            relevantLosses = losses.equipmentLosses?.map { $0.drone } ?? []
        case .navalShip:
            relevantLosses = losses.equipmentLosses?.map { $0.navalShip } ?? []
        case .antiAircraftWarfare:
            relevantLosses = losses.equipmentLosses?.map { $0.antiAircraftWarfare } ?? []
        case .specialEquipment:
            relevantLosses = losses.equipmentLosses?.map { $0.specialEquipment } ?? []
        case .vehiclesAndFuelTanks:
            relevantLosses = losses.equipmentLosses?.map { $0.vehiclesAndFuelTanks } ?? []
        case .cruiseMissiles:
            relevantLosses = losses.equipmentLosses?.map { $0.cruiseMissiles } ?? []
        }
        guard actualIndex < relevantLosses.count && actualIndex - 1 >= 0 else { return nil }
        if let todayLoss = relevantLosses[actualIndex], let yesterdayLoss = relevantLosses[actualIndex - 1] {
            let difference = todayLoss - yesterdayLoss
            let date = losses.equipmentLosses?[actualIndex].date ?? ""
            return DateLosses(dateLosses: String(difference), date: date)
        }
        return nil
    }

    private func calculateIncreasingLossDays() {
        var relevantLosses: [Int?] = []
        switch lossType {
        case .personnel:
            relevantLosses = losses.personnelLosses?.map { $0.personnel } ?? []
        case .aircraft:
            relevantLosses = losses.equipmentLosses?.map { $0.aircraft } ?? []
        case .helicopter:
            relevantLosses = losses.equipmentLosses?.map { $0.helicopter } ?? []
        case .tank:
            relevantLosses = losses.equipmentLosses?.map { $0.tank } ?? []
        case .armouredPersonnelCarrier:
            relevantLosses = losses.equipmentLosses?.map { $0.armouredPersonnelCarrier } ?? []
        case .fieldArtillery:
            relevantLosses = losses.equipmentLosses?.map { $0.fieldArtillery } ?? []
        case .multipleRocketLauncher:
            relevantLosses = losses.equipmentLosses?.map { $0.multipleRocketLauncher } ?? []
        case .drone:
            relevantLosses = losses.equipmentLosses?.map { $0.drone } ?? []
        case .navalShip:
            relevantLosses = losses.equipmentLosses?.map { $0.navalShip } ?? []
        case .antiAircraftWarfare:
            relevantLosses = losses.equipmentLosses?.map { $0.antiAircraftWarfare } ?? []
        case .specialEquipment:
            relevantLosses = losses.equipmentLosses?.map { $0.specialEquipment } ?? []
        case .vehiclesAndFuelTanks:
            relevantLosses = losses.equipmentLosses?.map { $0.vehiclesAndFuelTanks } ?? []
        case .cruiseMissiles:
            relevantLosses = losses.equipmentLosses?.map { $0.cruiseMissiles } ?? []
        }
        for index in 1 ..< relevantLosses.count {
            if let currentLoss = relevantLosses[index],
               let previousLoss = relevantLosses[index - 1],
               currentLoss > previousLoss {
                increasingLossDays.append(index)
            }
        }
    }
}
