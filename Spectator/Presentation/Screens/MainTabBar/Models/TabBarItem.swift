//
//  TabBarItem.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

import UIKit

enum TabBarItem: Int, CaseIterable {
    case lossesTab
    case equipmentTab
    case moreTab

    var title: String {
        switch self {
        case .lossesTab:
            return LocalizedString.lossesTab.localized
        case .equipmentTab:
            return LocalizedString.equipmentTab.localized
        case .moreTab:
            return LocalizedString.moreTab.localized
        }
    }

    var image: UIImage? {
        Constants.SystemImage.circle.image
    }

    var selectedImage: UIImage? {
        Constants.SystemImage.circleInsetFilled.image
    }
}
