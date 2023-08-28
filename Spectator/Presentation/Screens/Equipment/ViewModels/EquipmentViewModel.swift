//
//  EquipmentViewModel.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

final class EquipmentViewModel {
    private var allLosses: [OryxLoss]?
    private var filteredLosses: [OryxLoss]?
    private(set) var currentEquipmentUa = EquipmentType.all

    init(losses: [OryxLoss]?) {
        allLosses = losses
        filteredLosses = losses
    }

    var currentLosses: [OryxLoss] {
        filteredLosses ?? []
    }

    var numberOfEquipmentItems: Int {
        filteredLosses?.count ?? 0
    }

    var numberOfEquipmentTypes: Int {
        EquipmentType.allCases.count
    }

    func getEquipmentType(forIndex index: Int) -> EquipmentType? {
        guard let equipmentType = EquipmentType.allCases.safeElement(at: index) else { return nil }
        return equipmentType
    }

    func isEquipmentTypeCellSelected(atIndex index: Int) -> Bool {
        guard let equipmentType = EquipmentType.allCases.safeElement(at: index) else { return false }
        return currentEquipmentUa == equipmentType
    }

    func loss(at index: Int) -> OryxLoss? {
        filteredLosses?[index]
    }

    func filterByEquipmentUa(_ equipment: EquipmentType) {
        currentEquipmentUa = equipment
        guard equipment != .all else {
            resetFilters()
            return
        }
        filteredLosses = allLosses?.filter { $0.equipmentType == equipment }
    }

    func filterByModel(_ model: String) {
        if currentEquipmentUa == .all {
            filteredLosses = allLosses?.filter { $0.model.contains(model) }
        } else {
            filteredLosses = allLosses?.filter { $0.equipmentType == currentEquipmentUa && $0.model.contains(model) }
        }
    }

    func resetFilters() {
        filteredLosses = allLosses
    }
}
