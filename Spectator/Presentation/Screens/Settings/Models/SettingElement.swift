//
//  SettingElement.swift
//  Spectator
//
//  Created by Beavean on 28.08.2023.
//

import Foundation

enum SettingElement: CaseIterable {
    case donateToArmy
    case airAlarmMap
    case warMap
    case developedBy

    var title: String {
        switch self {
        case .donateToArmy:
            return LocalizedString.donateToArmyText.localized
        case .developedBy:
            return LocalizedString.developedByText.localized
        case .warMap:
            return LocalizedString.openWarMap.localized
        case .airAlarmMap:
            return LocalizedString.openAirAlarmMap.localized
        }
    }

    var urlString: String {
        switch self {
        case .donateToArmy:
            return Constants.URLs.donateLink
        case .developedBy:
            return Constants.URLs.developerLink
        case .warMap:
            return Constants.URLs.deepStateLink
        case .airAlarmMap:
            return Constants.URLs.airAlarmMapLink
        }
    }
}
