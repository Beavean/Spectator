//
//  SettingElement.swift
//  Spectator
//
//  Created by Beavean on 28.08.2023.
//

import Foundation

enum SettingElement: CaseIterable {
    case donateToArmy
    case developedBy

    var title: String {
        switch self {
        case .donateToArmy:
            return LocalizedString.donateToArmyText.localized
        case .developedBy:
            return LocalizedString.developedByText.localized
        }
    }

    var urlString: String {
        switch self {
        case .donateToArmy:
            return Constants.URLs.donateLink
        case .developedBy:
            return Constants.URLs.developerLink
        }
    }
}
