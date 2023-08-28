//
//  String+Localized.swift
//  Spectator
//
//  Created by Beavean on 27.08.2023.
//

import Foundation

extension String {
    init(localized: LocalizedString) {
        self = NSLocalizedString(localized.rawValue, comment: "")
    }
}
