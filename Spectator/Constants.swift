//
//  Constants.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import UIKit

enum Constants {
    enum StyleDefaults {
        static let smallPadding: CGFloat = 8
        static let mediumPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 16
    }

    enum URLs {
        private static let baseUrl = "https://github.com/MacPaw/2022-Ukraine-Russia-War-Dataset/raw/main/data/"
        static let equipmentLosses = baseUrl + "russia_losses_equipment.json"
        static let personnelLosses = baseUrl + "russia_losses_personnel.json"
        static let equipmentOryxLosses = baseUrl + "russia_losses_equipment_oryx.json"

        static let donateLink = "https://savelife.in.ua/DONATE/"
        static let developerLink = "https://github.com/Beavean"
        static let deepStateLink = "https://deepstatemap.live/#6/49.438/32.053"
        static let foundationLink = "https://macpaw.foundation/#donate"
    }

    enum Colors: String {
        case blueFlag
        case border
        case label
        case background
        case secondaryBackground
        case secondaryLabel
        case yellowFlag
        case primaryAccentColor

        var color: UIColor { UIColor(named: rawValue) ?? .black.withAlphaComponent(0.5) }
    }

    enum SystemImage: String {
        case circleFilled = "circle.fill"
        case squarePlaceholder = "checkmark.square"
        case chevronRight = "chevron.right"
        case circle
        case circleInsetFilled = "circle.inset.filled"
        case chevronLeft = "chevron.left.2"

        var image: UIImage? { UIImage(systemName: rawValue) }
    }
}
